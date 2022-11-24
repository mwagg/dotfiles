local use = require("packer").use

use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup({})
  end
}
