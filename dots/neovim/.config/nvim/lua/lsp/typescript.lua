require'lspconfig'.tsserver.setup {on_attach = require('completion').on_attach}

vim.cmd(
    'autocmd BufWritePre *.js,*.jsx,*.json,*.tsx,*.ts :lua vim.lsp.buf.formatting_sync(nil, 1000)')
