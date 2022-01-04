local use = require("packer").use

use {
    "neovim/nvim-lspconfig",
    requires = {"tami5/lspsaga.nvim", "hrsh7th/cmp-nvim-lsp"},
    config = function()
        local lspconfig = require "lspconfig"

        -- ******************************
        -- LSP config
        -- ******************************
        require'lspsaga'.init_lsp_saga({
            code_action_keys = {quit = '<esc>', exec = '<CR>'},
            finder_action_keys = {
                open = '<cr>',
                vsplit = 's',
                split = 'i',
                quit = '<esc>',
                scroll_down = '<C-f>',
                scroll_up = '<C-b>'
            }
        })

        local common_on_attach = function(_, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            -- Mappings.
            local opts = {noremap = true, silent = true}

            buf_set_keymap('n', '<leader>ca', "<cmd>lua require('lspsaga.codeaction').code_action()<cr>", opts)
            buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
            buf_set_keymap('n', '<leader>cr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
            buf_set_keymap('n', '[e', "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            buf_set_keymap('n', ']e', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            buf_set_keymap('n', '<leader>ch', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
        end

        local configure_format_on_save = function(name, file_types)
            local cmd = vim.api.nvim_command
            cmd("augroup autoformat_" .. name)
            cmd('autocmd!')
            for _, file_type in pairs(file_types) do
                cmd("autocmd BufWritePre " .. file_type .. " lua vim.lsp.buf.formatting()")
            end
            cmd("augroup END")
        end

        local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- EFM
        lspconfig.efm.setup({
            cmd = {"efm-langserver"},
            capabilities = capabilities,
            init_options = {documentFormatting = true, codeAction = false},
            filetypes = {"lua"},
            settings = {
                rootMarkers = {".git/"},
                languages = {
                    lua = {
                        {
                            formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
                            formatStdin = true
                        }
                    }
                }
            }
        })

        -- Lua
        configure_format_on_save("lua", {"*.lua"})
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")
        lspconfig.sumneko_lua.setup({
            settings = {
                capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            -- Setup your lua path
                            path = vim.split(package.path, ";")
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {"vim"}
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                            },
                            maxPreload = 10000
                        }
                    }
                }
            },
            on_attach = common_on_attach
        })

        -- Nix
        lspconfig.rnix.setup({on_attach = common_on_attach})
        configure_format_on_save("nix", {"*.nix"})
    end
}
