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

  vim.keymap.set("n", "<leader>/", ":Telescope live_grep<cr>", {desc="Search across project"})
  vim.keymap.set("n", "<leader>*", ":Telescope grep_string<cr>", {desc={"Search word under cursor"}})
  vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<cr>", {desc="Find files"})
  vim.keymap.set("n", "<leader>fp", ":Telescope projects<cr>", {desc="Find project"})
  vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme<cr>", {desc="Find colorscheme"})
  vim.keymap.set("n", "<leader>bb", ":Telescope buffers<cr>", {desc="Find buffer"})
  vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>", {desc="Find branches"})
  vim.keymap.set("n", "<leader>gl", ":Telescope git_commits<cr>", {desc="Find commits"})
  vim.keymap.set("n", "<leader>hh", ":Telescope help_tags<cr>", {desc="Find help"})
  vim.keymap.set("n", "<leader>cd", ":Telescope diagnostics<cr>", {desc="Show diagnostics"})
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
}
