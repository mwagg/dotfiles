return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ruby-lsp",
        "rubocop",
        "sorbet",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        sorbet = function(_, opts)
          opts.root_dir = require('lspconfig.util').root_pattern "sorbet/config"
          return opts
        end
      }
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "zidhuss/neotest-minitest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("neotest-minitest"),
      })
    end,
  },
}
