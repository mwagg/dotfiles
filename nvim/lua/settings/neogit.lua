local use = require("packer").use

use {
    "TimUntersberger/neogit",
    requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
    after = "which-key.nvim",
    config = function()
        require'diffview'.setup({
            key_bindings = {
                file_panel = {["q"] = ":DiffviewClose<cr>"},
                file_history_panel = {["q"] = ":DiffviewClose<cr>"}
            }
        })

        require('neogit').setup({integrations = {diffview = true}})

        require('which-key').register({
            g = {g = {"<cmd>Neogit<CR>", "Neogit"}, h = {"<cmd>DiffviewFileHistory<cr>", "File history"}}
        }, {prefix = "<leader>"})
    end
}
