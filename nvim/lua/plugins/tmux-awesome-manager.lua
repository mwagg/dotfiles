return {
  "otavioschwanck/tmux-awesome-manager.nvim",
  keys = {
    {
      "<leader>cu",
      function()
        local tmux_term = require("tmux-awesome-manager.src.term")
        tmux_term.execute_command({ name = "Dev up", cmd = "/opt/dev/bin/dev up", open_as = "pane" })
      end,
      desc = "Dev up",
    },
    {
      "<leader>fs",
      function()
        local tmux_term = require("tmux-awesome-manager.src.term")
        tmux_term.execute_command({
          name = "Switch tmux project",
          cmd = "tmux-sessionizer",
          open_as = "window",
          read_after_cmd = false,
        })
      end,
      desc = "Switch tmux project",
    },
    {
      "<leader>`",
      function()
        local tmux_term = require("tmux-awesome-manager.src.term")
        tmux_term.execute_command({
          name = "Open terminal",
          cmd = "/usr/bin/env zsh",
          read_after_cmd = false,
        })
      end,
      desc = "Open terminal",
    },
  },
}
