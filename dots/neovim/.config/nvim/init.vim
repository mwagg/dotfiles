scriptencoding utf-8

let g:mapleader=' '
let g:maplocalleader=','

let path = "$HOME/.config/nvim"
exec 'source' path . '/plugins.vim'
exec 'source' path . '/windows.vim'
exec 'source' path . '/fzf.vim'
exec 'source' path . '/terminal.vim'
exec 'source' path . '/nerdtree.vim'
exec 'source' path . '/coc.vim'
exec 'source' path . '/elm.vim'
exec 'source' path . '/fugitive.vim'

" source init.vim whenever it is saved
augroup reload_config
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end

" clear whitespace on save
set list
augroup whitespace
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup end

" use system clipboard
set clipboard=unnamed

" line numbers
set number
set relativenumber

" show preview for substitutions
set inccommand=split

colorscheme molokai
