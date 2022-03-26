local use = require("packer").use

use {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.indentscope").setup({})
        require("mini.jump").setup({})
        require("mini.surround").setup({})
    end
}
