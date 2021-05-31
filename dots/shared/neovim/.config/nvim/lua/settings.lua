vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.opt.syntax = 'enable' -- syntax highlighting
vim.opt.hidden = true -- allow multiple open buffers
vim.opt.wrap = false -- don't wrap lines
vim.opt.encoding = 'utf-8' -- encoding
vim.opt.fileencoding = 'utf-8' -- encoding
vim.opt.ruler = true -- show cursor position
vim.opt.cmdheight = 2 -- make more space for messages
vim.opt.splitbelow = true -- horizontal splits will automatically be below
vim.opt.splitright = true -- vertical splits will automatically be to the right
vim.opt.smartindent = true -- indenting
vim.opt.autoindent = true -- indenting
vim.opt.laststatus = 2 -- always show statusline
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- use relative line numbers
vim.opt.background = 'dark' -- tell vim what the background color looks like
vim.opt.backup = false -- don't backup files
vim.opt.writebackup = false -- don't backup files
vim.opt.signcolumn = 'yes' -- always show the signcolumn, otherwise it would shift the text each time
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- by default timeoutlen is 1000 ms
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.incsearch = true -- show search matches while typing
vim.opt.inccommand = 'nosplit' -- show result of substitution as you type
vim.opt.mouse = 'a'
vim.opt.ts = 2
vim.opt.sw = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- don't automatically add comment on newline
vim.cmd('filetype plugin on') -- need to make sure the autocmd is after this
vim.cmd('autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o')

-- highlight on yank
vim.cmd('augroup name')
vim.cmd('autocmd!')
vim.cmd('autocmd TextYankPost *, lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})')
vim.cmd('augroup END')
