-- return {
--   "vim-test/vim-test",
--   keys = {
--     { "<leader>tt", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
--     { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run test file" },
--     { "<leader>tl", "<cmd>TestLast<cr>", desc = "Re-run last test" },
--   },
--   config = function()
--     vim.cmd("let test#strategy = 'neovim'")
--   end,
-- }

return {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",
  "zidhuss/neotest-minitest",
  {
    "nvim-neotest/neotest",
    opts = function(opts)
      return {
        adapters = {
          require("neotest-minitest"),
        },
      }
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run test file",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Re-run last test",
      },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Re-run last test",
      },
    },
  },
}
