scriptencoding utf-8

let g:mapleader=' '
let g:maplocalleader=','

let path = "$HOME/.config/nvim"
exec 'source' path . '/plugins.vim'
exec 'source' path . '/windows.vim'
exec 'source' path . '/terminal.vim'
exec 'source' path . '/nerdtree.vim'
exec 'source' path . '/coc.vim'
exec 'source' path . '/elm.vim'
exec 'source' path . '/terraform.vim'
exec 'source' path . '/fugitive.vim'
exec 'source' path . '/find.vim'
exec 'source' path . '/vim-test.vim'

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
"
" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" stop accidentally entering exmode
map q: <Nop>
nnoremap Q <nop>

" use four spaces for javascript
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType javascriptreact setlocal ts=4 sts=4 sw=4

set lazyredraw

" format whole file
nnoremap <leader>== gg=G<C-o>

hi Normal guibg=NONE ctermbg=NONE
