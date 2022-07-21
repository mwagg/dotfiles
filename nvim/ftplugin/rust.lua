local term = require('toggleterm')
require("key-menu").set("n", "<leader>r", { desc = "Rust", buffer = true })

vim.keymap.set("n", "<leader>cb", function()
  term.exec("cargo build")
end, { desc = "cargo build", buffer = true })
vim.keymap.set("n", "<leader>cr", function()
  term.exec("cargo run")
end, { desc = "cargo run", buffer = true })
