-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Git related
vim.keymap.del("n", "<leader>gG")
vim.keymap.del("n", "<leader>gL")
vim.keymap.del("n", "<leader>gl")
