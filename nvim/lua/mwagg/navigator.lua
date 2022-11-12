local use = require("packer").use

use({
  'ray-x/navigator.lua',
  requires = {
    { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
    { 'neovim/nvim-lspconfig' },
  },
  config = function()
    require('navigator').setup({
      lsp = {
        format_on_save = true
      }
    })
  end
})
