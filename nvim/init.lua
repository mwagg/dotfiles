function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^mwagg') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

vim.api.nvim_create_user_command("ReloadConfig", "lua ReloadConfig()", {})

require("mwagg/plugins")
require("mwagg/mappings")
require("mwagg/options")
-- require("mwagg/autocmd")
