" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"" Improved motion in Vim
"Plug 'easymotion/vim-easymotion'
"
"" Intellisense Engine
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"
"" Snippet support
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
"
"" Print function signatures in echo area
"Plug 'Shougo/echodoc.vim'
"
"" === Git Plugins === "
"" Enable git changes to be shown in sign column
"Plug 'mhinz/vim-signify'
"Plug 'tpope/vim-fugitive'
"
"" === Elm Plugins === "
"Plug 'Zaptic/elm-vim'
"
""" ReactJS JSX syntax highlighting
""Plug 'mxw/vim-jsx'
""
""" Generate JSDoc commands based on function signature
""Plug 'heavenshell/vim-jsdoc'
""
""" === Syntax Highlighting === "
"
"" Syntax highlighting for javascript libraries
"Plug 'othree/javascript-libraries-syntax.vim'
"
"" Improved syntax highlighting and indentation
"Plug 'othree/yajs.vim'
"
"" === UI === "
"" File explorer
"
"" Customized vim status line
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"
"" Icons
"
"" Initialize plugin system
call plug#end()

