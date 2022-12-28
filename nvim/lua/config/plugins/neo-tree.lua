return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
  config = function()
    require('neo-tree').setup()
  end,
  keys = {
    { '<leader>e', '<cmd>Neotree reveal<cr>', desc = 'Show current file in tree' },
  }
}
