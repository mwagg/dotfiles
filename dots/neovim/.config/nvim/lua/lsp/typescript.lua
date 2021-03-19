require'lspconfig'.tsserver.setup {}

vim.cmd(
    'autocmd BufWritePre *.js,*.jsx,*.json,*.tsx,*.ts :lua vim.lsp.buf.formatting_sync(nil, 1000)')
