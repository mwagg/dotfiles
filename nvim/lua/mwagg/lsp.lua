local use = require("packer").use

use {
  "ray-x/lsp_signature.nvim",
  config = function()
    require "lsp_signature".setup()
  end
}

use {
  "neovim/nvim-lspconfig",
  requires = {
    "tami5/lspsaga.nvim", "hrsh7th/cmp-nvim-lsp", "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/nvim-lsp-ts-utils", "williamboman/nvim-lsp-installer"
  },
  config = function()
    local lspconfig = require "lspconfig"
    require("nvim-lsp-installer").setup({ automatic_installation = true })

    -- ******************************
    -- LSP config
    -- ******************************
    require 'lspsaga'.init_lsp_saga({
      code_action_keys = { quit = '<esc>', exec = '<CR>' },
      finder_action_keys = {
        open = '<cr>',
        vsplit = 's',
        split = 'i',
        quit = '<esc>',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>'
      }
    })

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
      end

      -- Mappings.
      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>ca", ":lua require('lspsaga.codeaction').code_action()<cr>", { desc = "Code action" })
      vim.keymap.set("n", "<leader>cr", ":Telescope lsp_references<cr>", { desc = "References" })
      vim.keymap.set("n", "<leader>cf", ":lua vim.lsp.buf.formatting()<CR>", { desc = "Format" })

      buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
      buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
      buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
      buf_set_keymap('n', '[e', "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
      buf_set_keymap('n', ']e', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

      if client.resolved_capabilities.document_formatting then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
          pattern = "<buffer>",
          callback = function()
            vim.lsp.buf.formatting()
          end
        })
      end
    end

    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Lua
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
    }

    -- Ruby - sorbet
    lspconfig.sorbet.setup({ on_attach = on_attach, capabilities = capabilities, cmd={ "bundle", "exec", "srb", "tc", "--lsp" } })
    lspconfig.solargraph.setup({ on_attach = on_attach, capabilities = capabilities })

    -- TypeScript
    lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })

    -- GraphQL
    lspconfig.graphql.setup({})
  end
}
