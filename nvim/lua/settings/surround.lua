local use = require("packer").use

use {
    "blackCauldron7/surround.nvim",
    config = function()
        require"surround".setup {mappings_style = "surround"}
    end
}
