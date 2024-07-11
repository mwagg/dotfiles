return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "tpope/vim-fugitive" },
    keys = { {
      "<Leader>gg",
      "<cmd>DiffviewOpen<cr>",
      desc = "Diff",
    } },
    opts = {
      keymaps = {
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
          { "n", "cc", "<Cmd>Git commit <bar> wincmd J<CR>", { desc = "Commit staged changes" } },
          { "n", "ca", "<Cmd>Git commit --amend <bar> wincmd J<CR>", { desc = "Amend the last commit" } },
        },
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
        },
      },
    },
  },
}
