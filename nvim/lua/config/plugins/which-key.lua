return {
  'folke/which-key.nvim',
  init = function()
    local wk = require('which-key')
    wk.setup()

    wk.register({
      v = { name = 'Vim' },
      b = { name = 'Buffers' },
      g = { name = 'Git' },
      c = { name = 'Code' },
      d = { name = 'Code diagnostics' },
      t = { name = 'Tests' },
    }, { prefix = '<leader>' })
  end,
}
