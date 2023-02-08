return {
  "vim-test/vim-test",
  keys = {
    { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
    { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run test file" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Re-run last test" },
  },
  config = function()
    vim.cmd("let test#strategy = 'neovim'")
  end,
}
