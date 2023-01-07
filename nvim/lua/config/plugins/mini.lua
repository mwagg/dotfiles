return {
  'echasnovski/mini.nvim',
  init = function()
    require("mini.indentscope").setup({})
    require("mini.jump").setup({})
    require("mini.surround").setup({})
    require("mini.starter").setup({})
    require("mini.comment").setup({})
  end
}
