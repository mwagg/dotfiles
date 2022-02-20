local use = require("packer").use

use {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.surround").setup({})
    end
}
