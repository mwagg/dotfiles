require'lspconfig'.solargraph.setup {
    settings = {
        solargraph = {
            autoformat = true,
            bundlerPath = '~/.asdf/shims/bundle'
        }
    }
}

vim.cmd('autocmd BufWritePre *.rb :lua vim.lsp.buf.formatting_sync(nil, 1000)')

