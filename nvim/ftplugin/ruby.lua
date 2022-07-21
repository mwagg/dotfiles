local term = require('toggleterm')
require("key-menu").set("n", "<leader>r", { desc = "Ruby", buffer = true })

vim.keymap.set("n", "<leader>cc", function()
  term.toggle_command("./bin/rails console", 12)
end, { desc = "rails console", buffer = true })

vim.keymap.set("n", "<leader>rs", function()
  term.exec("../bin/dev")
end, { desc = "Rails dev server", buffer = true })
