return {
  "tanvirtin/vgit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>VGit project_diff_preview<cr>", desc = "Status" },
  },
  config = true,
}
