local wk = require('whichkey_setup')
local keymap = {h = {h = {':HopWord<cr>', 'Word'}}}
wk.register_keymap('leader', keymap)
