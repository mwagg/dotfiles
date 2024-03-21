return {
  { "nvim-neotest/nvim-nio" },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>tt",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run(vim.fn.expand("%"))
        end,
        desc = "Run tests in current file",
      },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle output panel",
      },
      {
        "<leader>tl",
        function()
          local neotest = require("neotest")
          neotest.output_panel.clear()
          neotest.run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle test summary panel",
      },
    },
    {
      "<leader>ta",
      function()
        local neotest = require("neotest")
        neotest.output_panel.clear()
        neotest.run.attach()
      end,
      desc = "Attach to nearest test",
    },
  }
}
