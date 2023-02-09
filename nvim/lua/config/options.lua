-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if os.getenv("SPIN") ~= nil then
  vim.cmd("source /usr/share/nvim/sysinit.vim")
end
