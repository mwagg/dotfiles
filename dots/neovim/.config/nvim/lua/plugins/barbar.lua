-- Move to previous/next
vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', { silent = true, noremap = true })
-- Re-order to previous/next
vim.api.nvim_set_keymap('n', '<A-<>', ':BufferMovePrevious<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A->>', ':BufferMoveNext<CR>', { silent = true, noremap = true })
