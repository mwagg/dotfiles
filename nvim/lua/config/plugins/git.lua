return {
  {
    'lewis6991/gitsigns.nvim',
    init = function()
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
          ignore_whitespace = false,
        },
      })
    end
  },
  {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    config = function()
      require 'diffview'.setup({
        key_bindings = {
          file_panel = { ['q'] = ':DiffviewClose<cr>' },
          file_history_panel = { ['q'] = ':DiffviewClose<cr>' }
        }
      })

      require('neogit').setup({ integrations = { diffview = true } })
    end,
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<CR>', desc = 'File history' },
    }
  }
}
