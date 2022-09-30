local use = require("packer").use

use {
  "lewis6991/gitsigns.nvim",
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('gitsigns').setup({
      keymaps = {
        -- Default keymap options
        noremap = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" }
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
      },
    })
  end
}
