return {
  { "omnisyle/nvim-hidesig", ft = "ruby" },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        hidesig = {
          enable = true,
          opacity = 0.75, -- opacity for sig definitions
          delay = 200, -- update delay on CursorMoved and InsertLeave
        },
      })
    end,
  },
}
