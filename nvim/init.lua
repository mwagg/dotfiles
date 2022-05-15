function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^mwagg') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

vim.cmd('command! ReloadConfig lua ReloadConfig()')

require("plugins")
require("mappings")
require("mwagg/options")
require("autocmd")
