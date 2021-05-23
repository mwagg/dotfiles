DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

require('plugins')
require('settings')
require('mappings')

-- LSP
require('lsp')

-- plugins
require('plugins/which-key')
require('plugins/telescope')
require('plugins/lspkind')
require('plugins/nvim-compe')
require('plugins/better-whitespace')
require('plugins/vim-polyglot')
require('plugins/lspconfig')
require('plugins/git-signs')
require('plugins/galaxyline')
require('plugins/neogit')
require('plugins/treesitter')
require('plugins/nvim-tree')
require('plugins/vim-rooter')
require('plugins/barbar')
require('plugins/symbols-outline')

vim.cmd('source ~/.config/nvim/theme.vim')
