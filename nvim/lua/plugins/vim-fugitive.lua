return {
  "tpope/vim-fugitive",
  cmd = { "Git" },
  keys = {
    { "<Leader>gp", "<cmd> Git pull --rebase<cr>", desc = "Pull" },
    { "<Leader>gP", desc = "Push" },
    { "<Leader>gPp", "<cmd> Git push<cr>", desc = "Push" },
    { "<Leader>gPf", "<cmd> Git push --force-with-lease<cr>", desc = "Force push" },
    { "<Leader>gl", "<cmd> Git log --oneline --graph -n 40<cr>", desc = "Log" },
  },
}
