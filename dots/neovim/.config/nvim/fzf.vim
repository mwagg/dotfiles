nnoremap <leader>pf :Files<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>tt :Colors<Cr>
nnoremap <leader>/ :Rg<cr>
nnoremap <leader>* :Rg <c-r><c-w><cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" customise Files command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'rg --files --hidden', 'options': ['--layout=reverse', '--info=inline']}), <bang>0)
