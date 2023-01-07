return {
  'rcarriga/nvim-notify',
  init = function()
    local notify = require('notify')
    notify.setup({
      background_colour = "Normal",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 5000,
      top_down = true
    })
    vim.notify = notify

    vim.keymap.set("n", "<esc>", function() require("notify").dismiss() end)
  end
}
