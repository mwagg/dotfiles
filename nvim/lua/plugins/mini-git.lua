return {
  {
    "echasnovski/mini-git",
    version = false,
    main = "mini.git",
    config = true,
    cmd = { "Git" },
    keys = {
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
    },
  },
}
