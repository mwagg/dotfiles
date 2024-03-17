return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")

    wk.register({
      ["<leader>gp"] = { name = "+Pull requests" },
      ["<leader>ga"] = { name = "Github actions" },
    })
  end,
  keys = {
    {
      "<leader>gaw",
      function()
        require("lazyvim.util").terminal({ "gh", "run", "watch" })
      end,
      desc = "Watch"
    },
    {
      "<leader>gav",
      function()
        require("lazyvim.util").terminal({ "gh", "run", "view" })
      end,
      desc = "View"
    },
    {
      "<leader>gpc",
      function()
        require("lazyvim.util").terminal({ "gh", "pr", "create" })
      end,
      desc = "Create"
    },

    {
      "<leader>gpm",
      function()
        require("lazyvim.util").terminal({ "gh", "pr", "merge" })
      end,
      desc = "Merge"
    }
  }
}
