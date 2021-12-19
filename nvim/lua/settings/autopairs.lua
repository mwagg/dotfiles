local use = require("packer").use

use {
    "windwp/nvim-autopairs",
    config = function()
        local autopairs = require("nvim-autopairs")
        autopairs.setup {}
    end
}
