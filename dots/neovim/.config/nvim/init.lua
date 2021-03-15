require('settings')
require('mappings')
vim.cmd('source ~/.config/nvim/theme.vim')
require('plugins')

-- LSP
require('lsp/lua')
require('lsp/typescript')

-- plugins
require('plugins/lsp-saga')
require('plugins/telescope')
require('plugins/lspkind')
require('plugins/completion-nvim')
vim.cmd('source ~/.config/nvim/plugins/which-key.vim')
vim.cmd('source ~/.config/nvim/plugins/better-whitespace.vim')
vim.cmd('source ~/.config/nvim/plugins/vim-polyglot.vim')
vim.cmd('source ~/.config/nvim/plugins/lspconfig.vim')
vim.cmd('source ~/.config/nvim/plugins/lsp-saga.vim')
vim.cmd('source ~/.config/nvim/plugins/barbar.vim')
vim.cmd('source ~/.config/nvim/plugins/floaterm.vim')
