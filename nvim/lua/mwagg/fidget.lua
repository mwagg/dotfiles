local use = require('packer').use

use {
  "j-hui/fidget.nvim",
  config = function()
    require "fidget".setup {}
  end
}
