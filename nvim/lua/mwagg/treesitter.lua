local use = require("packer").use

use {
  "nvim-treesitter/nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter-refactor",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = "all",
      ignore_install = { "haskell", "swift", "phpdoc" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          scope_incremental = "<cr>",
          node_incremental = "<tab>",
          node_decremental = "<s-tab>"
        }
      },
      indent = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 2000 -- Do not enable for files with more than specified lines
      },
      refactor = { highlight_definitions = { enable = true } }
    }
  end,
  run = ":TSUpdate"
}
