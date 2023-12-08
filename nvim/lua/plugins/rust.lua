return {
  {
    "nvim-neotest/neotest",
    dependecies = {
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("neotest-rust"),
      })
    end,
  },
  "rouge8/neotest-rust",
}
