local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function require_settings(name)
    require(string.format("settings/%s", name))
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
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
        vim.api.nvim_set_keymap("n", "<leader>pp", ":PackerSync<cr>", {silent = true, noremap = true})
        vim.api.nvim_set_keymap("n", "<leader>pc", ":PackerCompile<cr>", {silent = true, noremap = true})
    end
}

require_settings("nightfox")
require_settings("cmp")
require_settings("surround")
require_settings("which-key")
require_settings("telescope")
require_settings("lualine")
require_settings("autopairs")
require_settings("treesitter")
require_settings("gitsigns")
require_settings("vsnip")
require_settings("lsp")
require_settings("neogit")
require_settings("nvim-tree")
