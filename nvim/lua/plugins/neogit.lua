return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" } },
    config = {
      view = {
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_mixed",
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = true,         -- See |diffview-config-view.x.winbar_info|
        },
      }
    }
  },
}
