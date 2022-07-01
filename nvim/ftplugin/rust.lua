require("key-menu").set("n", "<leader>r", { desc = "Rust", buffer = true })

vim.keymap.set("n", "<leader>rb", function()
  require('FTerm').scratch({ cmd = { "cargo", "build" } })
end, { desc = "cargo build", buffer = true })
vim.keymap.set("n", "<leader>rr", function()
  require('FTerm').scratch({ cmd = { "cargo", "run" } })
end, { desc = "cargo run", buffer = true })
