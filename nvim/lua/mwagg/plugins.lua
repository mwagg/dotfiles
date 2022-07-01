local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute "packadd packer.nvim"
end

-- initialize and configure packer
local packer = require("packer")
packer.init {
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  display = {
    open_fn = require('packer.util').float,
  }
}
local use = packer.use
packer.reset()

use "wbthomason/packer.nvim"

require("mwagg/nightfox")
require("mwagg/cmp")
require("mwagg/telescope")
require("mwagg/lualine")
require("mwagg/autopairs")
require("mwagg/treesitter")
require("mwagg/gitsigns")
require("mwagg/snippets")
require("mwagg/lsp")
require("mwagg/neogit")
require("mwagg/neo-tree")
require("mwagg/comment")
require("mwagg/mini")
require("mwagg/fidget")
require("mwagg/keymenu")
require("mwagg/neotest")
require("mwagg/terminal")
