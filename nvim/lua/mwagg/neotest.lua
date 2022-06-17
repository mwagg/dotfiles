local use = require("packer").use

use {
  "rcarriga/neotest",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rcarriga/neotest-vim-test",
    "vim-test/vim-test",
    "rcarriga/neotest-plenary"
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
        require("neotest-plenary"),
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "✖",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "✔",
        running = "⟲",
        skipped = "ﰸ",
        unknown = "?"
      },
    })

    vim.keymap.set("n", "<leader>tt", function()
      neotest.run.run()
    end, { desc = "Run nearest test" })

    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current file" })

    vim.keymap.set("n", "<leader>ta", function()
      neotest.run.attach()
    end, { desc = "Attach to nearest test" })

    vim.keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, { desc = "Toggle test summary view" })

    vim.keymap.set("n", "<leader>tl", function()
      neotest.run.run_last()
    end, { desc = "Rerun last test" })
  end
}
