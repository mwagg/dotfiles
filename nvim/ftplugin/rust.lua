local tmux_term = require("tmux-awesome-manager.src.term")

local wk = require("which-key")
wk.register({ ["<leader>r"] = { name = "+rust", buffer = 0 } })
vim.keymap.set("n", "<leader>rr", tmux_term.run({ name = "Cargo run", cmd = "cargo run", open_as = "pane" }), {
  desc = "Cargo run",
  buffer = 0,
})
vim.keymap.set(
  "n",
  "<leader>rd",
  tmux_term.run({
    name = "Rust docs",
    cmd = "rustup docs --std",
    open_as = "pane",
    read_after_cmd = false,
  }),
  {
    desc = "Rust docs",
    buffer = 0,
  }
)
