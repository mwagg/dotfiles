local use = require("packer").use

use {
  "vim-test/vim-test",
  config = function()
    vim.cmd('let test#strategy = "neovim"')

    vim.keymap.set("n", "<leader>tt", ":TestNearest<cr>", { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<cr>", { desc = "Test file" })
    vim.keymap.set("n", "<leader>tl", ":TestLast<cr>", { desc = "Rerun last test" })
  end
}
