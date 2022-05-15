-- highlight on yank

local function highlight()
  require("vim.highlight").on_yank({ higroup = "Search", timeout = 200 })
end

local yank_group_id = vim.api.nvim_create_augroup("yank_highlight", {})
vim.api.nvim_create_autocmd("TextYankPost", { callback = highlight, group = yank_group_id })
