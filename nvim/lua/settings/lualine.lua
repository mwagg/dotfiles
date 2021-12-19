local use = require("packer").use

use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require('lualine').setup {options = {theme = "nightfox"}}
    end
}
