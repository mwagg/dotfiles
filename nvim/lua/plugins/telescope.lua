return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<esc>"] = require("telescope.actions").close,
          },
        },
        sorting_strategy = "ascending",
        layout_strategy = "center",
        border = false,
        prompt_title = "",
        results_title = "",
        preview_title = "",
        prompt_prefix = "",
        selection_caret = "",
        entry_prefix = "",
        multi_icon = "",
        color_devicons = false,
        preview = false,
        layout_config = {
          anchor = "N",
          width = 99,
        },
      },
    },
    -- apply the config and additionally load fzf-native
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
