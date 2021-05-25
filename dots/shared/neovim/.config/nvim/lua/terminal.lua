-- no line numbers in terminals
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
vim.cmd('autocmd TermOpen * startinsert')
vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
