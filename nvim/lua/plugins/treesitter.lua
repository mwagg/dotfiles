return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.endwise = { enable = true }
    table.insert(opts.ensure_installed, "ruby")
  end,
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
  },
}
