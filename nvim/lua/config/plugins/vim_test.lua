return {
  'vim-test/vim-test',
  config = function()
    vim.cmd('let test#strategy = "neovim"')
  end,
  keys = {
    { '<leader>tt', '<cmd>TestNearest<cr>', desc = 'Run nearest test' },
    { '<leader>tf', '<cmd>TestFile<cr>', desc = 'Test file' },
    { '<leader>tl', '<cmd>TestLast<cr>', desc = 'Rerun last test' },
  }
}
