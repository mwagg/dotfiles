augroup elm
	autocmd!
	autocmd BufWritePost *.elm call CocAction('format')
augroup end
