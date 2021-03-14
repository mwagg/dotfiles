set iskeyword+=-                      	" treat dash separated words as a word text object"
syntax enable                           " syntax highlighting
set hidden                              " allow multiple open buffers
set nowrap                              " don't wrap lines
set encoding=utf-8                      " encoding
set fileencoding=utf-8                  " encoding
set ruler			        " show cursor position
set cmdheight=2                         " make more space for messages
set splitbelow                          " horizontal splits will automatically be below
set splitright                          " vertical splits will automatically be to the right
set t_Co=256                            " 256 colour support
set smartindent                         " indenting
set autoindent                          " indenting
set laststatus=2                        " always show statusline
set number                              " show line numbers
set relativenumber                      " use relative line numbers
set background=dark                     " tell vim what the background color looks like
set nobackup                            " don't backup files
set nowritebackup                       " don't backup files
set signcolumn=yes                      " always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                      " faster completion
set timeoutlen=500                      " by default timeoutlen is 1000 ms
set clipboard=unnamedplus               " use system clipboard
set incsearch				" show search matches while typing
set inccommand=nosplit                  " show result of substitution as you type

" don't automatically add comment on newline
filetype plugin on " need to make sure the autocmd is after this
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" no line numbers in terminals
autocmd TermOpen * setlocal nonumber norelativenumber

hi Comment cterm=italic

syntax on
colorscheme monokai

" checks if terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

highlight Normal guibg=none
highlight NonText guibg=none
