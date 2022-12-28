return {
  'navarasu/onedark.nvim',
  init = function()
    vim.o.termguicolors = true
    vim.cmd [[colorscheme onedark]]
  end
}
