require'lspconfig'.pyls.setup {on_attach = require('completion').on_attach}

vim.cmd('autocmd BufWritePre *.py :lua vim.lsp.buf.formatting_sync(nil, 100)')
