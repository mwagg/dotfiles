-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.flit-nvim" },
  { import = "astrocommunity.syntax.vim-cool" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  -- import/override with your plugins folder
}
