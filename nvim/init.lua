vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Automatically source this file whenever it changes
local vim_rc_group = vim.api.nvim_create_augroup('VIMRC', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile>',
  group = vim_rc_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

vim.keymap.set('n', '<leader>vc', ':e $MYVIMRC<cr>', { desc = 'Edit init.lua' })

--
-- [[ General options ]]
--
vim.o.hlsearch = false -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.wo.relativenumber = true -- show relative line numbers
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250 -- Decrease update time
vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.clipboard = "unnamedplus" -- integrate with the system clipboard
vim.opt.wrap = false

--
-- [[ Basic Keymaps ]]
--
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- terminal window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('i', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- close window
vim.keymap.set('n', '<leader>q', '<cmd>close<cr>', { silent = true })

-- resize windows
vim.keymap.set('n', '<up>', '<cmd>resize -1<cr>')
vim.keymap.set('n', '<down>', '<cmd>resize +1<cr>')
vim.keymap.set('n', '<left>', '<cmd>vertical resize -1<cr>')
vim.keymap.set('n', '<right>', '<cmd>vertical resize +1<cr>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

--
-- [[ Terminal ]]
--
local terminal_group = vim.api.nvim_create_augroup('TERMINAL', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', { command = 'setlocal nonumber norelativenumber', group = terminal_group, })
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert', group = terminal_group, })
vim.api.nvim_create_autocmd('TermOpen', { command = 'setlocal signcolumn=no', group = terminal_group, })
vim.keymap.set('n', '<leader>`', ':terminal<cr>', { desc = 'Open terminal in this buffer' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('config.lazy')

-- vim: ts=2 sts=2 sw=2 et
