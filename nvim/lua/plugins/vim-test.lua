vim.g["test#strategy"] = "neovim_sticky"
vim.g["VimuxHeight"] = "40"
vim.g["VimuxOrientation"] = "h"

local prefix = "<Leader>T"

---@type LazySpec
return {
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestLast" },
    dependencies = {
      "preservim/vimux",
      {
        "AstroNvim/astrocore",
        opts = {

          mappings = {

            n = {
              [prefix] = { desc = "󰗇 Tests" },
              [prefix .. "t"] = { "<cmd>wall<cr><cmd>TestNearest<cr>", desc = "Run nearest test" },
              [prefix .. "f"] = { "<cmd>wall<cr><cmd>TestFile<cr>", desc = "Run tests in current file" },
              [prefix .. "l"] = { "<cmd>wall<cr><cmd>TestLast<cr>", desc = "Run last test" },
            },
          },
        },
      },
    },
  },
}
