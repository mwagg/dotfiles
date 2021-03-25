require'lspconfig'.elmls.setup{}

vim.cmd('autocmd BufWritePre *.elm :lua vim.lsp.buf.formatting_sync(nil, 1000)')
