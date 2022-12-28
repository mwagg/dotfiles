return {
  'lukas-reineke/indent-blankline.nvim',
  init = function()
    require('indent_blankline').setup {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  end
}
