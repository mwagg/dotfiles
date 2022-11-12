local use = require("packer").use

use {
  'romgrk/barbar.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    vim.keymap.set("n", "<leader>bb", ":BufferPick<cr>", { desc = "Find buffer" })

-- tab switch buffer
vim.keymap.set("n", "<TAB>", ":BufferNext<CR>")
vim.keymap.set("n", "<S-TAB>", ":BufferPrevious<CR>")

  end
}

