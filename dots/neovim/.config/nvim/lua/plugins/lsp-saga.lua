vim.api.nvim_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '[e', ":Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', ']e', ":Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
