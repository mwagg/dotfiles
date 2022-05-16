local use = require("packer").use

local function configure()
  local telescope_actions = require('telescope.actions')
  local telescope = require('telescope')

  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case',
        '--hidden'
      },
      find_command = {
        'rg', '--hidden', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
      },
      mappings = {
        i = {
          ["<C-j>"] = telescope_actions.move_selection_next,
          ["<C-k>"] = telescope_actions.move_selection_previous,
          ["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
          ["<C-l>"] = telescope_actions.smart_send_to_qflist,
          -- To disable a keymap, put [map] = false
          -- So, to not map "<C-n>", just put
          -- ["<c-x>"] = false,
          ["<esc>"] = telescope_actions.close,

          -- Otherwise, just set the mapping to the function that you want it to be.
          -- ["<C-i>"] = actions.select_horizontal,

          -- Add up multiple actions
          ["<CR>"] = telescope_actions.select_default + telescope_actions.center

          -- You can perform as many actions in a row as you like
          -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
        },
        n = {
          ["<C-j>"] = telescope_actions.move_selection_next,
          ["<C-k>"] = telescope_actions.move_selection_previous,
          ["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist
          -- ["<C-i>"] = my_cool_custom_action,
        }
      }
    },
    pickers = {
      find_files = { theme = "dropdown" },
      live_grep = { theme = "dropdown" },
      grep_string = { theme = "dropdown" },
      projects = { theme = "dropdown" },
      help_tags = { theme = "dropdown" },
      git_branches = { theme = "dropdown" },
      buffers = { theme = "dropdown" }
    }
  }
  telescope.load_extension('project')

  telescope.load_extension('lsp_handlers')

  require("which-key").register({
    ["/"] = { ":Telescope live_grep<cr>", "Live grep" },
    ["*"] = { ":Telescope grep_string<cr>", "Search word under cursor" },
    ["<leader>"] = { ":Telescope find_files hidden=true<cr>", "Find files" },
    f = { p = { ":Telescope project<cr>", "Project" }, c = { ":Telescope colorscheme<cr>", "Colorscheme" } },
    b = { b = { ":Telescope buffers<cr>", "Find buffer" } },
    g = { b = { ":Telescope git_branches<cr>", "Branches" }, l = { ":Telescope git_commits<cr>", "Search commits" } },
    h = { h = { ":Telescope help_tags<cr>", "Help tags" } },
    c = { name = "Code", d = { ":Telescope diagnostics<cr>", "Show diagnostics" } }
  }, { prefix = "<leader>" })
end

use {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "gbrlsnchs/telescope-lsp-handlers.nvim" },
  },
  config = configure,
  after = "which-key.nvim"
}
