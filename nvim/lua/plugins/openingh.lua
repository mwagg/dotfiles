return {
  "Almo7aya/openingh.nvim",
  cmd = { "OpenInGHRepo", "OpenInGHFile" },
  keys = {
    { "<leader>go", ":OpenInGHFile<cr>", desc = "Open this file in GitHub" },
    { "<leader>gO", ":OpenInGHRepo<cr>", desc = "Open this repo in GitHub" },
  },
}
