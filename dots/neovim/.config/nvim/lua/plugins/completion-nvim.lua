vim.cmd('set shortmess+=c') -- Avoid showing message extra message when using completion
vim.o.completeopt='menuone,noinsert,noselect' -- Set completeopt to have a better completion experience

vim.api.nvim_set_keymap('i', '<C-j>', 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { silent = true, noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-k>', 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { silent = true, noremap = true, expr = true })
