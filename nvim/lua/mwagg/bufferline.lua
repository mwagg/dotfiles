local use = require("packer").use

use {
  "akinsho/bufferline.nvim",
  tag = "v3.*",
  requires = { "kyazdani42/nvim-web-devicons" },
  config = function()
    vim.opt.termguicolors = true

    require("bufferline").setup {
      options = {
        mode = "buffers", -- "buffers" | "tabs"
        numbers = "none",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "slant",
      }
    }

    -- tab switch buffer
    vim.keymap.set("n", "<TAB>", ":BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<cr>", { desc = "Pick close buffers" })
  end
}
