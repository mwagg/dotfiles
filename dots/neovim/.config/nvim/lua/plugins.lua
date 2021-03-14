local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
  -- git
  use 'TimUntersberger/neogit'
  use 'rhysd/git-messenger.vim'
  use 'airblade/vim-gitgutter'
  -- which key
  use 'liuchengxu/vim-which-key'
  -- theme
  use 'sickill/vim-monokai'
  -- comments
  use 'tpope/vim-commentary'
  -- comments when mixed languages in file
  use 'suy/vim-context-commentstring'
  -- set the root dir automatically
  use 'airblade/vim-rooter'
  -- better whitespace
  use 'ntpeters/vim-better-whitespace'
  -- quick jump
  use 'justinmk/vim-sneak'
  -- surround
  use 'tpope/vim-surround'
  -- better syntax
  use 'sheerun/vim-polyglot'
  -- icons
  use 'ryanoasis/vim-devicons'
  -- auto pairs for '(' '[' '{'
  use 'jiangmiao/auto-pairs'
  -- closetags
  use 'alvan/vim-closetag'
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
end)
