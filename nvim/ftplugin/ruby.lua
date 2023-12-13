local tmux_term = require("tmux-awesome-manager.src.term")

local wk = require("which-key")
wk.register({ ["<leader>r"] = { name = "+ruby", buffer = 0 } })
vim.keymap.set("n", "<leader>rb", tmux_term.run({ name = "Bundle install", cmd = "bundle install", open_as = "pane" }), {
  desc = "Bundle install",
  buffer = 0,
})
vim.keymap.set("n", "<leader>rs",
  tmux_term.run({ name = "Rails server", cmd = "bundle exec rails s", open_as = "window" }),
  {
    desc = "Rails server",
    buffer = 0,
  })
vim.keymap.set("n", "<leader>rc",
  tmux_term.run({ name = "Rails console", cmd = "bundle exec rails c", open_as = "pane", read_after_cmd = false }), {
    desc = "Rails console",
    buffer = 0,
  })
vim.keymap.set("n", "<leader>rl",
  tmux_term.run({ name = "Rails lint", cmd = "bundle exec rubocop", open_as = "pane" }), {
    desc = "Lint (Rubocop)",
    buffer = 0,
  })
vim.keymap.set("n", "<leader>rt",
  tmux_term.run({ name = "Rails typecheck", cmd = "bundle exec srb", open_as = "pane" }), {
    desc = "Typecheck",
    buffer = 0,
  })
