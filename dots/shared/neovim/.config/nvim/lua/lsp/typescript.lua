require'lspconfig'.tsserver.setup {
      cmd = {DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio"},
    documentFormatting=true
}

vim.cmd(
    'autocmd BufWritePre *.js,*.jsx,*.json,*.tsx,*.ts :lua vim.lsp.buf.formatting_sync(nil, 1000)')
