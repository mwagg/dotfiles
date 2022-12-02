local use = require('packer').use

use {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
  end
}
