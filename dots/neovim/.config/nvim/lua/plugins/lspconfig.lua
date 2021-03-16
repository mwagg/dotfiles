vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true, noremap = true })

-- auto-format
vim.cmd('autocmd BufWritePre *.js,*.jsx,*.json,*.tsx,*.ts,*.py,*.lua :lua vim.lsp.buf.formatting_sync(nil, 100)')
