local use = require("packer").use

use {
  "dcampos/nvim-snippy",
  requires = "honza/vim-snippets",
  config = function()
    require('snippy').setup({
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
        },
        nx = {
          ['<leader>x'] = 'cut_text',
        },
      },
    })
  end
}
