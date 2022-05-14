-- enable hidden buffers
vim.opt.hidden = true

-- wrap text
vim.opt.wrap = false

-- use two lines for cmdline to prevent hit enter commands
vim.opt.cmdheight = 2

-- automatically indent lines
vim.opt.smartindent = true
vim.opt.autoindent = true

-- always display the status line
vim.opt.laststatus = 2

-- line numbers with relative line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- always show the sign column
vim.opt.signcolumn = "yes"

-- don't create backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- preview substitutions live
vim.opt.inccommand = "nosplit"

-- integrate with the system clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 300

-- reduce timeout for mapped sequences
vim.opt.timeoutlen = 500

-- enable mouse support
vim.opt.mouse = "a"

-- tabs/spacing config
vim.opt.ts = 2
vim.opt.sw = 4
vim.opt.expandtab = true

require("settings-terminal")
