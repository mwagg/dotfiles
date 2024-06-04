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
      servers = {
        sorbet = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("sorbet/config")(fname)
          end,
        },
      },
    },
  },
}
