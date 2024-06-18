return {
  "SuperBo/fugit2.nvim",
  opts = {
    width = 70,
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    {
      "chrisgrieser/nvim-tinygit",
      dependencies = { "stevearc/dressing.nvim" },
    },
  },
  cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
  keys = {
    { "<leader>gg", mode = "n", "<cmd>Fugit2<cr>", desc = "Status" },
  },
}
