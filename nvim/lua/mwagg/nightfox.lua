local use = require("packer").use

vim.opt.background = "dark"
vim.opt.termguicolors = true

use {
  "EdenEast/nightfox.nvim",
  config = function()
    vim.cmd("colorscheme terafox")
  end
}
