require('plugins')
require('settings')
require('mappings')
vim.cmd('source ~/.config/nvim/theme.vim')

-- LSP
require('lsp/lua')
require('lsp/typescript')
require('lsp/python')

-- plugins
require('plugins/lsp-saga')
require('plugins/telescope')
require('plugins/lspkind')
require('plugins/completion-nvim')
require('plugins/better-whitespace')
require('plugins/vim-polyglot')
require('plugins/lspconfig')
require('plugins/lsp-saga')
require('plugins/barbar')
require('plugins/floaterm')
vim.cmd('source ~/.config/nvim/plugins/which-key.vim')
vim.cmd('source ~/.config/nvim/plugins/neoformat.vim')
require('plugins/python')
