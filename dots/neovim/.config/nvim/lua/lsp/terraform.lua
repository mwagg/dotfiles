require'lspconfig'.terraformls.setup {
    on_attach = require('completion').on_attach
}

vim.cmd('autocmd BufWritePre *.tf :lua vim.lsp.buf.formatting_sync(nil, 100)')
