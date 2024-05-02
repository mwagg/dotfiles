return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    ...,
    "zidhuss/neotest-minitest",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup {
      adapters = {
        require "neotest-minitest",
      },
    }
  end,
}
