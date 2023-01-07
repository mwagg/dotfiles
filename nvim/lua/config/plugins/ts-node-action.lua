return {
  'ckolkey/ts-node-action',
  dependencies = { 'nvim-treesitter' },
  config = function() -- Optional
    require("ts-node-action").setup({})
    vim.keymap.set({ "n" }, "N", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
  end
}
