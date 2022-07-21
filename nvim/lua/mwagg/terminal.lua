local use = require("packer").use;

function TerminalCommand(cmd)
  vim.cmd("terminal " .. cmd)
end

use {
  "akinsho/toggleterm.nvim",
  config = function()
    local term = require("toggleterm")
    term.setup({
      start_in_insert = true
    })

    vim.keymap.set("n", "<leader>;", function()
      vim.cmd("ToggleTerm")
    end, { desc = "Toggle terminal" })
  end
}

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.cmd("autocmd TermOpen * setlocal signcolumn=no") -- no sign column in terminals
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber") -- no line numbers in terminals
