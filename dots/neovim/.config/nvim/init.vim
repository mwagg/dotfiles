scriptencoding utf-8

" Remap leader key to Space
let g:mapleader=' '
" Remap local leader to ','
let g:maplocalleader=','

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/fzf.vim
source ~/.config/nvim/neotree.vim
source ~/.config/nvim/javascript.vim

" Line numbers
set number
set relativenumber

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamed

" Hides buffers instead of closing them
set hidden

" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line Shows up in preview window when
" airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" tidy up whitespace on save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" fix lint errors on code where possible
let g:ale_fix_on_save = 1
" move to the next ALE warning / error
nnoremap ]r :ALENextWrap<CR>
" move to the previous ALE warning / error
nnoremap [r :ALEPreviousWrap<CR>

" === Easy-motion shortcuts ==="
""   <leader>w - Easy-motion highlights first word letters bi-directionally
"map <leader>w <Plug>(easymotion-bd-w)
"
"" Allows you to save files you opened without write permissions via sudo
"cmap w!! w !sudo tee %
"

"
"" === NeoSnippet
"" Map <C-k> as shortcut to activate snippet if available
"imap <C-k> <Plug>(neosnippet_expand_or_jump) smap <C-k>
"<Plug>(neosnippet_expand_or_jump) xmap <C-k> <Plug>(neosnippet_expand_target)
"
"" Load custom snippets from snippets folder
"let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
"
"" Hide conceal markers
"let g:neosnippet#enable_conceal_markers = 0
"
