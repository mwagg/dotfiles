vim.g.bufferline = {animation = true, auto_hide = true}

vim.api.nvim_set_keymap('n', '<A-,>', ":BufferPrevious<cr>",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<A-.>', ":BufferNext<cr>",
                        {silent = true, noremap = true})

local wk = require('whichkey_setup')

local keymap = {b = {d = {':BufferClose', 'Close'}}}

wk.register_keymap('leader', keymap)
