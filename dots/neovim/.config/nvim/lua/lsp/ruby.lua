require'lspconfig'.solargraph.setup {}

vim.cmd('autocmd BufWritePre *.rb :lua vim.lsp.buf.formatting_sync(nil, 1000)')

