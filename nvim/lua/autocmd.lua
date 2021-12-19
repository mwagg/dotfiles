-- highlight on yank
local cmd = vim.api.nvim_command
cmd("augroup yank_highlight")
cmd("autocmd!")
cmd("autocmd TextYankPost *, lua require(\"vim.highlight\").on_yank({higroup = \"Search\", timeout = 200})")
cmd("augroup END")
