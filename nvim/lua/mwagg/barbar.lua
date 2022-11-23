local use = require("packer").use

use {
  'romgrk/barbar.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    -- tab switch buffer
    vim.keymap.set("n", "<TAB>", ":BufferNext<CR>")
    vim.keymap.set("n", "<S-TAB>", ":BufferPrevious<CR>")
    vim.keymap.set("n", "<leader>bs", ":BufferCloseAllButCurrent<cr>", { desc = "Close all but current" })
  end
}
