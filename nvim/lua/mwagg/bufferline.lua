local use = require("packer").use

use {
  'akinsho/bufferline.nvim',
  tag = "v3.*",
  -- 'romgrk/barbar.nvim',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      diagnostics = "nvim_lsp"
    })
    -- tab switch buffer
    vim.keymap.set("n", "<TAB>", ":BufferLineMoveNext<CR>")
    vim.keymap.set("n", "<S-TAB>", ":BufferLineMovePrev<CR>")
    vim.keymap.set("n", "<leader>bs", ":BufferCloseAllButCurrent<cr>", { desc = "Close all but current buffer" })
  end
}
