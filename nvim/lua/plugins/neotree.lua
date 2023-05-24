return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
    },
    window = {
      mappings = {
        ["H"] = "prev_source",
        ["L"] = "next_source",
      },
    },
  },
}
