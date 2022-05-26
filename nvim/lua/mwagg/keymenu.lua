local use = require("packer").use

use {
  "linty-org/key-menu.nvim",
  config = function()
    local keymenu = require("key-menu")

    keymenu.set("n", "<Space>")
    keymenu.set("n", "<Space>f", { desc = "Find" })
    keymenu.set("n", "<Space>g", { desc = "Git" })
    keymenu.set("n", "<Space>n", { desc = "NeoVim" })
    keymenu.set("n", "<Space>b", { desc = "Buffers" })
    keymenu.set("n", "<Space>h", { desc = "Help" })
    keymenu.set("n", "<Space>c", { desc = "Code" })
  end
}
