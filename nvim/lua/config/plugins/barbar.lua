return {
  'romgrk/barbar.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '<leader>bd', '<cmd>BufferDelete<cr>', desc = 'Delete buffer' },
    { '<tab>', '<cmd>BufferNext<cr>', desc = 'Next buffer' },
    { '<s-tab>', '<cmd>BufferPrevious<cr>', desc = 'Previous buffer' },
  }
}
