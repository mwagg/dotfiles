return {
  'echasnovski/mini.nvim',
  init = function()
    require("mini.indentscope").setup({})
    require("mini.jump").setup({})
    require("mini.surround").setup({})
    require("mini.starter").setup({})
    require("mini.comment").setup({})
    require("mini.trailspace").setup({})
    require("mini.cursorword").setup({})
    require("mini.jump2d").setup({})
    require("mini.animate").setup({})

    vim.keymap.set("n", "<leader>j", MiniJump2d.start, { desc = "Jump to" })
  end
}
