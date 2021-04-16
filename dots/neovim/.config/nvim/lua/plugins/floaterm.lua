vim.g.floaterm_autoclose = 1
vim.g.floaterm_width = 0.5
vim.g.floaterm_height = 0.8
vim.g.floaterm_wintype = 'vsplit'

local wk = require('whichkey_setup')

local keymap = {
    t = {
        t = {':FloatermToggle<cr>', 'Toggle'},
        h = {':FloatermNew htop<cr>', 'Htop'},
        c = {':FloatermNew ctop<cr>', 'Ctop'},
        n = {':FloatermNext<cr>', 'Next'},
        p = {':FloatermPrev<cr>', 'Prev'}
    }
}

wk.register_keymap('leader', keymap)
