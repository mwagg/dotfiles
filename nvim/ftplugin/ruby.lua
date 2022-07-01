require("key-menu").set("n", "<leader>r", { desc = "Ruby", buffer = true })

vim.keymap.set("n", "<leader>rc", function()
  require('FTerm').scratch({ cmd = { "./bin/rails", "console" } })
end, { desc = "rails console", buffer = true })

vim.keymap.set("n", "<leader>rd", function()
  vim.cmd("terminal ./bin/dev")
end, { desc = "Rails dev", buffer = true })
