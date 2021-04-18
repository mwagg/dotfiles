local neogit = require('neogit')

neogit.setup {}

local wk = require('whichkey_setup')

local keymap = {g = {g = {':Neogit<cr>', 'Show Neogit'}}}

wk.register_keymap('leader', keymap)
