local use = require("packer").use

use {
  "windwp/nvim-autopairs",
  config = function() require("nvim-autopairs").setup {} end
}
