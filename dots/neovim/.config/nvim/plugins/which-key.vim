" leader Key Maps
let @s = 'veS"'

" timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

" map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
" create map to add keys to
let g:which_key_map =  {}
" define a separator
let g:which_key_sep = '→'

" Don't use floating window
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['.'] = [':e $MYVIMRC', 'open init']
let g:which_key_map['='] = ['<C-W>=', 'balance windows']

" g is for git
let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'g': [':Neogit', 'Show Neogit']
      \ }

" p is for packer
let g:which_key_map.p = {
      \ 'name': '+Packer',
      \ '.': [':e ~/.config/nvim/lua/plugins.lua', 'Edit plugins config'],
      \ 'p': [':PackerInstall', 'Install'],
      \ 'c': [':PackerClean', 'Clean'],
      \ }

call which_key#register('<Space>', "g:which_key_map")
