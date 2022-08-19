require("key-menu").set("n", "<leader>r", { desc = "Ruby", buffer = true })

vim.keymap.set("n", "<leader>rc", function()
  vim.cmd("belowright split term://./bin/rails c")
end, { desc = "rails console", buffer = true })

vim.keymap.set("n", "<leader>rs", function()
  vim.cmd("belowright split term://./bin/dev")
end, { desc = "Rails dev server", buffer = true })
