return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "ruby")
  end,
}
