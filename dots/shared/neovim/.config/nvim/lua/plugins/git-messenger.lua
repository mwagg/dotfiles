local wk = require('whichkey_setup')

local keymap = {g = {m = {':GitMessenger<cr>', 'Git message'}}}

wk.register_keymap('leader', keymap)
