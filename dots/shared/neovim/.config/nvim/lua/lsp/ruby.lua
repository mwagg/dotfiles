require'lspconfig'.solargraph.setup {
    settings = {
        solargraph = {
            autoformat = true,
            bundlerPath = '/home/mike/.asdf/shims/bundle'
        }
    }
}

vim.cmd('autocmd BufWritePre *.rb :lua vim.lsp.buf.formatting_sync(nil, 1000)')

