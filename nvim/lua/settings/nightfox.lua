local use = require("packer").use

use {
    "EdenEast/nightfox.nvim",
    config = function()
        require('nightfox').load("nightfox")
    end
}
