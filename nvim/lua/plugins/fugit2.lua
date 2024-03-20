return {
  'SuperBo/fugit2.nvim',
  opts = {},
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    {
      'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
      dependencies = { 'stevearc/dressing.nvim' }
    },
    'sindrets/diffview.nvim' -- optional: for Diffview
  },
  cmd = { 'Fugit2', 'Fugit2Graph' },
  keys = { { '<leader>gg', '<cmd>Fugit2<CR>', { desc = { "Fugit 2" } } } },
}
