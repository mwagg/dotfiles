return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
  init = function()
    local lsp = require('lsp-zero')

    lsp.preset('recommended')

    lsp.ensure_installed({
      'tsserver',
      'solargraph',
      'sumneko_lua',
      'rust_analyzer',
    })

    lsp.nvim_workspace()
    lsp.setup()

    -- format on save
    local format_on_save_group = vim.api.nvim_create_augroup('LSPFormatOnSaveGroup', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
      callback = function()
        vim.lsp.buf.format()
      end,
      group = format_on_save_group,
      pattern = '*',
    })
  end
}
