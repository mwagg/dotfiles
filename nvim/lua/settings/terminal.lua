-- terminal window navigation
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<C-\\><C-N><C-w>h', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<C-\\><C-N><C-w>j', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<C-\\><C-N><C-w>k', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<C-\\><C-N><C-w>l', {silent = true, noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {silent = true, noremap = true})

vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber") -- no line numbers in terminals
vim.cmd("autocmd TermOpen * startinsert") -- switch to insert mode when opening a terminal
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert") -- switch to insert mode when entering a terminal
vim.cmd("autocmd TermOpen * setlocal signcolumn=no") -- no sign column in terminals

vim.api.nvim_set_keymap("n", "<leader>t", ":terminal<cr>", {silent = true, noremap = true})
