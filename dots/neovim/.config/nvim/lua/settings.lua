vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.o.syntax = 'enable' -- syntax highlighting
vim.o.hidden = true -- allow multiple open buffers
vim.wo.wrap = false -- don't wrap lines
vim.o.encoding = 'utf-8' -- encoding
vim.o.fileencoding = 'utf-8' -- encoding
vim.o.ruler = true -- show cursor position
vim.o.cmdheight = 2 -- make more space for messages
vim.o.splitbelow = true -- horizontal splits will automatically be below
vim.o.splitright = true -- vertical splits will automatically be to the right
vim.o.t_Co = '256' -- 256 colour support
vim.o.smartindent = true -- indenting
vim.o.autoindent = true -- indenting
vim.o.laststatus = 2 -- always show statusline
vim.wo.number = true -- show line numbers
vim.wo.relativenumber = true -- use relative line numbers
vim.o.background = 'dark' -- tell vim what the background color looks like
vim.o.backup = false -- don't backup files
vim.o.writebackup = false -- don't backup files
vim.wo.signcolumn = 'yes' -- always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- faster completion
vim.o.timeoutlen = 500 -- by default timeoutlen is 1000 ms
vim.o.clipboard = 'unnamedplus' -- use system clipboard
vim.o.incsearch = true -- show search matches while typing
vim.o.inccommand = 'nosplit' -- show result of substitution as you type
vim.o.mouse = 'a'

-- don't automatically add comment on newline
vim.cmd('filetype plugin on') -- need to make sure the autocmd is after this
vim.cmd(
    'autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')

-- no line numbers in terminals
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
