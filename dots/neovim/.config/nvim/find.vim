nnoremap <silent> <leader>pf :CocList files<cr>
nnoremap <silent> <leader>bb :CocList buffers<cr>
nnoremap <silent> <leader>tt :CocList colors<cr>
nnoremap <silent> <leader>/ :CocList grep<cr>

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <leader>* :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

nnoremap <silent> <leader>ff :CocListResume<cr>
