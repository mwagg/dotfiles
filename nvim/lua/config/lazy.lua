-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Bootstrapping lazy.nvim")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
  install = {
    colorscheme = { "onedark" }
  }
})

vim.keymap.set('n', '<leader>vi', '<cmd>Lazy install<cr>', { desc = 'Lazy install' })
