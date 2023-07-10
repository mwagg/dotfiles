return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.endwise = { enable = true }
  end,
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
  },
}
