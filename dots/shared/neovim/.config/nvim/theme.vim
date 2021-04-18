syntax on
colorscheme dracula

" checks if terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

highlight Normal guibg=none
highlight NonText guibg=none
highlight Pmenu ctermbg=gray guibg=gray
