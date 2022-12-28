local servers = {
  rust_analyzer = {},
  tsserver = {},
  solargraph = {},
  sorbet = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>cr', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code action')

  nmap('gd', vim.lsp.buf.definition, 'Goto definition')
  nmap('gI', vim.lsp.buf.implementation, 'Goto implementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type definition')

  nmap('K', vim.lsp.buf.hover, 'Hover documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

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

return {
  {
    'j-hui/fidget.nvim',
    init = function()
      require('fidget').setup()
    end
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig'
    },
    init = function()
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }
    end
  },
  {
    'folke/neodev.nvim',
    init = function()
      require('neodev').setup()
    end
  }
}
