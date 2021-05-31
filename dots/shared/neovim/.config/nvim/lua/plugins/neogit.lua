local neogit = require('neogit')

neogit.setup {}

vim.cmd('augroup neogit_spelling')
vim.cmd('autocmd!')
vim.cmd('autocmd filetype gitcommit set spell')
vim.cmd('augroup END')
