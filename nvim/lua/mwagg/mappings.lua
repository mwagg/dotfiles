local map = vim.api.nvim_set_keymap
local default_options = {noremap = true, silent = true}

-- escape without the stretch
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', default_options)

-- map the leader key
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- tab switch buffer
map("n", "<TAB>", ":bnext<CR>", default_options)
map("n", "<S-TAB>", ":bprevious<CR>", default_options)

-- resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_options)
map("n", "<Right>", ":vertical resize -1<CR>", default_options)
map("n", "<Up>", ":resize -1<CR>", default_options)
map("n", "<Down>", ":resize +1<CR>", default_options)

-- source current file as lua
map("n", "<leader>fl", ":luafile %<CR>", default_options)
