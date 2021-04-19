local wk = require('whichkey_setup')

local keymap = {s = {':FloatermNew rails server<cr>', 'run server'}}

local bufnr = vim.api.nvim_buf_get_number(0)
print(bufnr)

wk.register_keymap('localleader', keymap,
                   {noremap = true, silent = true, bufnr = bufnr})
