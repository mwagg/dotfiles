local use = require('packer').use;

use {
  "numToStr/FTerm.nvim",
  config = function()
    vim.keymap.set("n", "<leader>``", function()
      require('FTerm').toggle()
    end, { desc = "Toggle terminal" })
  end
}

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.cmd("autocmd TermOpen * setlocal signcolumn=no") -- no sign column in terminals
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber") -- no line numbers in terminals
