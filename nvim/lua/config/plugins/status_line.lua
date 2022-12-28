return {
  'nvim-lualine/lualine.nvim',
  init = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    }
  end
}
