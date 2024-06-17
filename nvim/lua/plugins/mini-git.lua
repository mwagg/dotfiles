return {
  {
    "echasnovski/mini-git",
    version = false,
    main = "mini.git",
    config = true,
    cmd = { "Git" },
    keys = {
      { "<leader>ga", "<cmd>Git commit --amend<cr>", desc = "Amend" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull" },
      { "<leader>gP", desc = "Push" },
      { "<leader>gPp", "<cmd>Git push<cr>", desc = "Push" },
      { "<leader>gPf", "<cmd>Git push --force-with-lease<cr>", desc = "Push (force)" },
    },
  },
}
