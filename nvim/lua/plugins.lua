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
    threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
}
local use = packer.use
packer.reset()

use {
    "wbthomason/packer.nvim",
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>pp", ":PackerSync<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>pc", ":PackerCompile<cr>", { silent = true, noremap = true })
    end
}

require("settings-nightfox")
require("settings-cmp")
require("settings-which-key")
require("settings-telescope")
require("settings-lualine")
require("settings-autopairs")
require("settings-treesitter")
require("settings-gitsigns")
require("settings-snippets")
require("settings-lsp")
require("settings-neogit")
require("settings-neo-tree")
require("settings-comment")
require("settings-mini")
