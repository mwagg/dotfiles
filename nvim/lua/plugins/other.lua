return {
  "rgroli/other.nvim",
  cmd = { "Other" },
  keys = {
    { "<leader>fo", "<cmd>Other<cr>", desc = "Open other file" },
  },
  opts = {
    mappings = { "rails" },
  },
  config = function(_, opts)
    require("other-nvim").setup(opts)
  end,
}
