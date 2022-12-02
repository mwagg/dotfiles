local use = require("packer").use

use("williamboman/mason.nvim")
use({
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "jsonls",
        "rust_analyzer",
        "sumneko_lua",
        "tsserver",
        "solargraph",
        "yamlls",
      }
    })
  end,
})

use({
  "ray-x/navigator.lua",
  requires = {
    { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
  config = function()
    local key_maps = {
      { key = "gr", func = require("navigator.reference").async_ref, desc = "async_ref" },
      { key = "<Leader>gr", func = require("navigator.reference").reference, desc = "reference" }, -- reference deprecated
      { mode = "i", key = "<M-k>", func = vim.lsp.signature_help, desc = "signature_help" },
      { key = "<M-k>", func = vim.lsp.buf.signature_help, desc = "signature_help" },
      { key = "g0", func = require("navigator.symbols").document_symbols, desc = "document_symbols" },
      { key = "gW", func = require("navigator.workspace").workspace_symbol_live, desc = "workspace_symbol_live" },
      { key = "<c-]>", func = require("navigator.definition").definition, desc = "definition" },
      { key = "gd", func = require("navigator.definition").definition, desc = "definition" },
      { key = "gD", func = vim.lsp.buf.declaration, desc = "declaration" },
      { key = "gp", func = require("navigator.definition").definition_preview, desc = "definition_preview" },
      { key = "<leader>ca", mode = "n", func = require("navigator.codeAction").code_action, desc = "Code action" },
      {
        key = "<leader>ca",
        mode = "v",
        func = require("navigator.codeAction").range_code_action,
        desc = "range_code_action",
      },
      { key = "<leader>cr", func = require("navigator.rename").rename, desc = "Rename" },
      { key = "<leader>D", func = vim.lsp.buf.type_definition, desc = "type_definition" },
      { key = "gL", func = require("navigator.diagnostics").show_diagnostics, desc = "show_diagnostics" },
      { key = "gG", func = require("navigator.diagnostics").show_buf_diagnostics, desc = "show_buf_diagnostics" },
      { key = "]d", func = vim.diagnostic.goto_next, desc = "next diagnostics" },
      { key = "[d", func = vim.diagnostic.goto_prev, desc = "prev diagnostics" },
      { key = "]O", func = vim.diagnostic.set_loclist, desc = "diagnostics set loclist" },
      { key = "]r", func = require("navigator.treesitter").goto_next_usage, desc = "goto_next_usage" },
      { key = "[r", func = require("navigator.treesitter").goto_previous_usage, desc = "goto_previous_usage" },
      { key = "<C-LeftMouse>", func = vim.lsp.buf.definition, desc = "definition" },
      { key = "g<LeftMouse>", func = vim.lsp.buf.implementation, desc = "implementation" },
      { key = "<Leader>k", func = require("navigator.dochighlight").hi_symbol, desc = "hi_symbol" },
      { key = "<leader>wa", func = require("navigator.workspace").add_workspace_folder, desc = "add_workspace_folder" },
      {
        key = "<leader>wr",
        func = require("navigator.workspace").remove_workspace_folder,
        desc = "remove_workspace_folder",
      },
      { key = "<leader>cf", func = vim.lsp.buf.format, mode = "n", desc = "Format file" },
      { key = "<leader>wl", func = require("navigator.workspace").list_workspace_folders, desc = "list_workspace_folders" },
      { key = "<leader>cl", mode = "n", func = require("navigator.codelens").run_action, desc = "run code lens action" },
      { key = "<leader>mm", mode = "n", func = require("mason.ui").open, desc = "Open Mason" },
    }

    require("navigator").setup({
      lsp = {
        format_on_save = true
      },
      default_mapping = false,
      keymaps = key_maps,
      mason = true,
    })
  end
})
