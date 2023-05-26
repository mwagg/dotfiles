-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber") -- no line numbers in terminals
vim.cmd("autocmd TermOpen *  if nvim_buf_get_name(0) =~# '^term://.*' | startinsert | endif") -- switch to insert mode when opening a terminal
vim.cmd("autocmd TermOpen * setlocal signcolumn=no") -- no sign column in terminals
