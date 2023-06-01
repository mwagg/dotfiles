-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "<Esc>", ":Noice dismiss<cr>")
vim.keymap.set("n", "<Esc>", function()
  require("noice.view.backend.notify").dismiss()
end)
