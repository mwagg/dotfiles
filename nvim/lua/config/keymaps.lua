-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "<Esc>", ":Noice dismiss<cr>")
vim.keymap.set("n", "<Esc>", function()
  require("noice.view.backend.notify").dismiss()
end)

vim.keymap.set("i", "jk", "<esc>")

-- github related keymaps
vim.keymap.set("n", "<leader>gaw", function()
  require("lazyvim.util").terminal({ "gh", "run", "watch" })
end, { desc = "Watch" })

vim.keymap.set("n", "<leader>gav", function()
  require("lazyvim.util").terminal({ "gh", "run", "view" })
end, { desc = "View" })

vim.keymap.set("n", "<leader>gpc", function()
  require("lazyvim.util").terminal({ "gh", "pr", "create" })
end, { desc = "Create" })
