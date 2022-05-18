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

vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber") -- no line numbers in terminals
vim.cmd("autocmd TermOpen * startinsert") -- switch to insert mode when opening a terminal
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert") -- switch to insert mode when entering a terminal
vim.cmd("autocmd TermOpen * setlocal signcolumn=no") -- no sign column in terminals

vim.keymap.set("n", "<leader>t", ":terminal<cr>")
