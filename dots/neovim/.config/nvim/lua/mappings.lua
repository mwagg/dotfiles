-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- leader
vim.api
    .nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- escape without the stretch
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {silent = true, noremap = true})

-- move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
vim.api.nvim_set_keymap('x', 'K', ":move '<-2<CR>gv-gv",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('x', 'J', ":move '<+1<CR>gv-gv",
                        {silent = true, noremap = true})

-- terminal window navigation
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<C-\\><C-N><C-w>h',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<C-\\><C-N><C-w>j',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<C-\\><C-N><C-w>k',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<C-\\><C-N><C-w>l',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>',
                        {silent = true, noremap = true})

-- use alt + hjkl to resize windows
vim.api.nvim_set_keymap('n', '<M-j>', ':resize -2<CR>',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':resize +2<CR>',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<M-h>', ':vertical resize -2<CR>',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<M-l>', ':vertical resize +2<CR>',
                        {silent = true, noremap = true})

vim.g.which_key_timeout = 100
-- vim.g.which_key_display_names = {['<CR>'] = '↵', ['<TAB>'] = '⇆'}
vim.g.which_key_sep = '→'
vim.g.which_key_use_floating_win = 0
vim.g.which_key_max_size = 0

local wk = require('whichkey_setup')

local keymap = {
    ['.'] = {':e $MYVIMRC<cr>', 'Open init'},
    ['='] = {'<c-w=', 'Balance windows'},
    [' '] = {':Telescope find_files hidden=true<cr>', 'Find files'},
    ['/'] = {':Telescope live_grep<cr>', 'Live grep'},
    ['*'] = {':Telescope grep_string<cr>', 'Grep string'},
    g = {name = '+git'}
}

wk.register_keymap('leader', keymap)
