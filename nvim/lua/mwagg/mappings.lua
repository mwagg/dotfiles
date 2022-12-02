-- escape without the stretch
vim.keymap.set("i", "jk", "<Esc>")

-- map the leader key
vim.keymap.set("n", "<Space>", "<NOP>")
vim.g.mapleader = " "

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>")
vim.keymap.set("n", "<Up>", ":resize -1<CR>")
vim.keymap.set("n", "<Down>", ":resize +1<CR>")

-- buffers
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { desc = "Delete buffer" })
