local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
local packer = require('packer')
local use = packer.use

return packer.startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
    -- git
    use 'TimUntersberger/neogit'
    use 'rhysd/git-messenger.vim'
    use 'airblade/vim-gitgutter'
    -- which key
    use 'liuchengxu/vim-which-key'
    use 'AckslD/nvim-whichkey-setup.lua'
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
    use 'onsails/lspkind-nvim'
    use 'kabouzeid/nvim-lspinstall'
    -- telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    -- nvim tree
    use 'kyazdani42/nvim-tree.lua'
    -- tab line
    use 'kyazdani42/nvim-web-devicons'
    -- floaterm
    use 'voldikss/vim-floaterm'
    -- completion
    use 'hrsh7th/nvim-compe'
    -- statusline
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        opt = false
    }
    use 'nvim-treesitter/nvim-treesitter'
    use 'phaazon/hop.nvim'
end)
