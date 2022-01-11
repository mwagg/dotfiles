local use = require("packer").use

use {
    "windwp/nvim-autopairs",
    config = function()
        local autopairs = require("nvim-autopairs")
        autopairs.setup {}
        autopairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
    end
}
