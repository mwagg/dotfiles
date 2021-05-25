local utils = require('utils')

vim.fn.sign_define("LspDiagnosticsSignError",
                   {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})

vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> ca :Lspsaga code_action<CR>")
vim.cmd("nnoremap <silent> K :Lspsaga hover_doc<CR>")
vim.cmd("nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>")
vim.cmd("nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>")
vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {prefix = "", spacing = 0},
    signs = true,
    underline = true
})

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ", "   (Method)", "   (Function)", "   (Constructor)", " ﴲ  (Field)", "[] (Variable)",
    "   (Class)", " ﰮ  (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)", "   (Value)",
    " 練 (Enum)", "   (Keyword)", "   (Snippet)", "   (Color)", "   (File)", "   (Reference)",
    "   (Folder)", "   (EnumMember)", " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)", "   (Operator)",
    "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
    end
end

local function common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)
end

function tsserver_on_attach(client, bufnr)
    common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

local sumneko_root_path = DATA_PATH .. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
local tsserver_args = {
    {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}, {
        formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
        formatStdin = true,
        lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
        lintFormats = {"%f:%l:%c: %m"},
        lintIgnoreExitCode = true,
        lintStdin = true
    }
}

local servers = {
    sumneko_lua = {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        on_attach = common_on_attach,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                    },
                    maxPreload = 10000
                }
            }
        }
    },

    efm = {
        cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
        init_options = {documentFormatting = true, codeAction = false},
        filetypes = {
            "lua", "python", "javascriptreact", "javascript", "typescript", "typescriptreact", "sh", "html", "css",
            "json", "yaml", "markdown", "vue"
        },
        settings = {
            rootMarkers = {".git/"},
            languages = {
                python = {
                    {
                        LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
                        lintFormats = {"%f:%l:%c: %m"},
                        lintStdin = true
                    }, {formatCommand = "isort --quiet -", formatStdin = true},
                    {formatCommand = "black --quiet -", formatStdin = true}
                },
                lua = {
                    {
                        formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
                        formatStdin = true
                    }
                },
                sh = {
                    {formatCommand = "shfmt -ci -s -bn", formatStdin = true}, {
                        LintCommand = "shellcheck -f gcc -x",
                        lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"}
                    }
                },
                javascript = tsserver_args,
                javascriptreact = tsserver_args,
                typescript = tsserver_args,
                typescriptreact = tsserver_args,
                html = {prettier},
                css = {prettier},
                json = {prettier},
                yaml = {prettier}
            }
        }
    },
    yamlls = {},
    terraformls = {filetypes = {"terraform", "tf"}},
    solargraph = {settings = {solargraph = {autoformat = true, bundlerPath = '~/.asdf/shims/bundle'}}},
    elmls = {},
    tsserver = {
        cmd = {DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio"},
        filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
        },
        on_attach = tsserver_on_attach,
        root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
        settings = {documentFormatting = false},
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = {spacing = 0, prefix = ""},
                signs = true,
                underline = true,
                update_in_insert = true
            })
        }
    }
}

for server, config in pairs(servers) do require('lspconfig')[server].setup(config) end

utils.define_augroups({
    _auto_formatters = {
        {'BufWritePre', '*.py', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.js', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.jsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.ts', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.tsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.lua', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.json', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.yml', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.tf', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.rb', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufWritePre', '*.elm', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
    }
})
