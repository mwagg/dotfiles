syntax on
colorscheme monokai

" checks if terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

highlight Normal guibg=none
highlight NonText guibg=none

