local use = require("packer").use

use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons'},
    after = "which-key.nvim",
    config = function()
        require'nvim-tree'.setup {}

        require("which-key").register({f = {f = {":NvimTreeFindFile<cr>", "Show current file in tree"}}},
                                      {prefix = "<leader>"})
    end
}
