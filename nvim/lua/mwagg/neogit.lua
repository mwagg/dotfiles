local use = require("packer").use

use {
  "TimUntersberger/neogit",
  requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  config = function()
    require 'diffview'.setup({
      key_bindings = {
        file_panel = { ["q"] = ":DiffviewClose<cr>" },
        file_history_panel = { ["q"] = ":DiffviewClose<cr>" }
      }
    })

    require('neogit').setup({ integrations = { diffview = true } })

    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })
    vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "File history" })
  end
}
