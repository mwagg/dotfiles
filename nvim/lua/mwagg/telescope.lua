local use = require("packer").use

local function configure()
  local telescope_actions = require('telescope.actions')
  local telescope = require('telescope')

  telescope.setup {
    defaults = {
      file_ignore_patterns = { ".git/" },
      mappings = {
        i = {
          ["<C-j>"] = telescope_actions.move_selection_next,
          ["<C-k>"] = telescope_actions.move_selection_previous,
          ["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
          ["<C-l>"] = telescope_actions.smart_send_to_qflist,
          ['<c-d>'] = require('telescope.actions').delete_buffer,
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
          ["<C-q>"] = telescope_actions.smart_send_to_qflist + telescope_actions.open_qflist,
          -- ["<C-i>"] = my_cool_custom_action,
        }
      }
    },
    pickers = {
      find_files = { hidden = true },
    }
  }
  telescope.load_extension('project')

  telescope.load_extension('lsp_handlers')

  vim.keymap.set("n", "<leader>/", ":Telescope live_grep<cr>", { desc = "Search across project" })
  vim.keymap.set("n", "<leader>*", ":Telescope grep_string<cr>", { desc = { "Search word under cursor" } })
  vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<cr>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>fp", ":Telescope projects<cr>", { desc = "Find project" })
  vim.keymap.set("n", "<leader>fc", ":Telescope colorscheme<cr>", { desc = "Find colorscheme" })
  vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>", { desc = "Find branches" })
  vim.keymap.set("n", "<leader>gl", ":Telescope git_commits<cr>", { desc = "Find commits" })
  vim.keymap.set("n", "<leader>hh", ":Telescope help_tags<cr>", { desc = "Find help" })
  vim.keymap.set("n", "<leader>cd", ":Telescope diagnostics<cr>", { desc = "Show diagnostics" })
  vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<cr>", { desc = "Find LSP symbols in document" })
  vim.keymap.set("n", "<leader>fS", ":Telescope lsp_workspace_symbols<cr>", { desc = "Find LSP symbols in workspace" })
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
