require("key-menu").set("n", "<leader>r", { desc = "Rust", buffer = true })

vim.keymap.set("n", "<leader>rb", function()
  vim.cmd("belowright split term://cargo build")
end, { desc = "cargo build", buffer = true })
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("belowright split term://cargo run")
end, { desc = "cargo run", buffer = true })
