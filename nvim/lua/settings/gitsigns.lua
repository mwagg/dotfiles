local use = require("packer").use

use {
    "lewis6991/gitsigns.nvim",
    requires = {'nvim-lua/plenary.nvim'},
    after = "which-key.nvim",
    config = function()
        require('gitsigns').setup({
            keymaps = {
                -- Default keymap options
                noremap = true,

                ['n ]c'] = {expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
                ['n [c'] = {expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"}
            }
        })
        require('which-key').register({
            g = {
                s = {"<cmd>Gitsigns stage_hunk<CR>", "Stage hunk"},
                u = {"<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk"},
                r = {"<cmd>Gitsigns reset_hunk<CR>", "Reset hunk"},
                R = {"<cmd>Gitsigns reset_buffer<CR>", "Reset buffer"},
                p = {"<cmd>Gitsigns preview_hunk<CR>", "Preview hunk"},
                S = {"<cmd>Gitsigns stage_buffer<CR>", "Stage buffer"},
                U = {"<cmd>Gitsigns reset_buffer_index<CR>", "Reset buffer index"}
            }
        }, {prefix = "<leader>"})
    end
}
