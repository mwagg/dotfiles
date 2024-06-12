-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Git related
vim.keymap.set("n", "<leader>gb", function()
  require("telescope.builtin").git_branches()
end, { desc = "Branches" })
vim.keymap.set("n", "<leader>gl", function()
  require("telescope.builtin").git_commits()
end, { desc = "Commits" })
vim.keymap.set("n", "<leader>gz", function()
  require("telescope.builtin").git_stash()
end, { desc = "Stashes" })
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
