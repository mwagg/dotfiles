require'lspconfig'.pyright.setup {
    cmd = {
        DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
        "--stdio"
    },
    settings = {python = {analysis = {typeCheckingMode = "off"}}}
}

vim.cmd('autocmd BufWritePre *.py :lua vim.lsp.buf.formatting_sync(nil, 2000)')
