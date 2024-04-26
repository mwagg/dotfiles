vim.g["test#strategy"] = "vimux"
vim.g["VimuxHeight"] = "30"
vim.g["VimuxOrientation"] = "h"

return {
  {
    "vim-test/vim-test",
    dependencies = 'preservim/vimux',
    keys = {
      { "<leader>tt", "<cmd>wall<cr><cmd>TestNearest<cr>", desc = "Run nearest test", },
      { "<leader>tf", "<cmd>wall<cr><cmd>TestFile<cr>",    desc = "Run tests in current file", },
      { "<leader>tl", "<cmd>wall<cr><cmd>TestLast<cr>",    desc = "Run last test", },
    },
  },
  { 'preservim/vimux' },
}
