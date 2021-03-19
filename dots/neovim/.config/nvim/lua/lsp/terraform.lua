require'lspconfig'.terraformls.setup {}

vim.cmd('autocmd BufWritePre *.tf :lua vim.lsp.buf.formatting_sync(nil, 100)')
