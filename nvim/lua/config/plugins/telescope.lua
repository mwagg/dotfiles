return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope_actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
              ["<esc>"] = telescope_actions.close,
            },
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
    end,
    keys = {
      { '<leader>?', function() require('telescope.builtin').oldfiles() end, desc = 'Find recently opened files' },
      { '<leader>bb', function() require('telescope.builtin').buffers() end, desc = 'Find existing buffers' },
      { '<leader><space>', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<leader>h', function() require('telescope.builtin').help_tags() end, desc = 'Search help' },
      { '<leader>*', function() require('telescope.builtin').grep_string() end, desc = 'Search current word' },
      { '<leader>/', function() require('telescope.builtin').live_grep() end, desc = 'Live grep' },
      { 'gr', function() require('telescope.builtin').lsp_references() end, desc = 'Goto references' },
      { '<leader>cs', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
        desc = 'Search workspace symbols' }
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable('make') == 1,
  },
}
