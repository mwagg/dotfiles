local use = require("packer").use

use {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup({})

    wk.register({
      b = { name = "Buffers" },
      c = { name = "Code" },
      f = { name = "Find" },
      g = { name = "Git" },
      t = { name = "Tests" },
      w = { name = "Workspace" },
      m = { name = "Mason" },
    }, { prefix = "<leader>" })
  end
}
