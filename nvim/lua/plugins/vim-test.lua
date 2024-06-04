vim.g["test#strategy"] = "neovim_sticky"

local prefix = "<Leader>t"

return {
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestLast" },
    keys = {
      { prefix .. "t", "<cmd>wall<cr><cmd>TestNearest<cr>", desc = "Run nearest test" },
      { prefix .. "f", "<cmd>wall<cr><cmd>TestFile<cr>", desc = "Run tests in current file" },
      { prefix .. "l", "<cmd>wall<cr><cmd>TestLast<cr>", desc = "Run last test" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        [prefix] = { name = "+test" },
      },
    },
  },
}
