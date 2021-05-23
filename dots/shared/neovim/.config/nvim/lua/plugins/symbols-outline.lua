local opts = {
    highlight_hovered_item = true,
    show_guides = true,
}

require('symbols-outline').setup(opts)

local wk = require('whichkey_setup')

local keymap = {c = {s = {':SymbolsOutline<cr>', 'Symbols outline'}}}

wk.register_keymap('leader', keymap)

