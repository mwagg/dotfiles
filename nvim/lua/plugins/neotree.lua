return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
    },
    window = {
      mappings = {
        ["h"] = "toggle_hidden",
        ["H"] = "prev_source",
        ["L"] = "next_source",
      },
    },
  },
}
