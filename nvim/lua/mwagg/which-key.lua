local use = require("packer").use

use {
  "folke/which-key.nvim",
  config = function()
    local whichkey = require("which-key")
    whichkey.setup({})
    whichkey.register({ n = "+NeoVim", g = "+Git", b = "+Buffers", f = "+Find", h = "+Help" }, { prefix = "<leader>" })
  end
}
