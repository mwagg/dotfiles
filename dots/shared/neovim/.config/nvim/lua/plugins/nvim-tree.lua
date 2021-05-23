local wk = require('whichkey_setup')

local keymap = {
    f = {
        f = {':NvimTreeFindFile<cr>', 'Find file'},
        t = {':NvimTreeToggle<cr>', 'Toggle'}
    }
}

wk.register_keymap('leader', keymap)

