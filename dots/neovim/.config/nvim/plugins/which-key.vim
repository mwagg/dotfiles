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

" e is for file explorer
let g:which_key_map.e = {
      \ 'name': '+file explorer',
      \ 'e': [':NvimTreeToggle', 'Toggle file explorer'],
      \ 'f': [':NvimTreeFindFile', 'Toggle find file'],
      \}

" p is for packer
let g:which_key_map.p = {
      \ 'name': '+Packer',
      \ '.': [':e ~/.config/nvim/lua/plugins.lua', 'Edit plugins config'],
      \ 'p': [':PackerInstall', 'Install'],
      \ 'c': [':PackerClean', 'Clean'],
      \ }

" c is for LSP
let g:which_key_map.c = {
      \ 'name': '+LSP',
      \ 's': [':Lspsaga signature_help', 'Signature help'],
      \ 'r': [':Lspsaga rename', 'Rename'],
      \ 'd': [':Lspsaga preview_definition', 'Preview definition'],
      \ 'e': [':Lspsaga show_line_diagnostics', 'Show line diagnostics'],
      \ 'a': [':Lspsaga code_action', 'Code actions'],
      \ 'E' : [':Telescope lsp_document_diagnostics', 'document_diagnostics'],
      \ }

" f is for find powered by telescope
let g:which_key_map.f = {
      \ 'name' : '+search',
      \ 'a' : [':Telescope lsp_code_actions', 'code_actions'],
      \ 'b' : [':Telescope buffers', 'buffers'],
      \ 'C' : [':Telescope git_bcommits', 'git_bcommits'],
      \ 'f' : [':Telescope file_browser', 'files'],
      \ 'F' : [':Telescope git_files', 'git_files'],
      \ 'g' : [':Telescope tags', 'tags'],
      \ 'G' : [':Telescope current_buffer_tags', 'buffer_tags'],
      \ 'h' : [':Telescope command_history', 'history'],
      \ 'H' : [':Telescope help_tags', 'help_tags'],
      \ 'i' : [':Telescope media_files', 'media files'],
      \ 'k' : [':Telescope keymaps', 'keymaps'],
      \ 'l' : [':Telescope loclist', 'loclist'],
      \ 'm' : [':Telescope marks', 'marks'],
      \ 'M' : [':Telescope man_pages', 'man_pages'],
      \ 'o' : [':Telescope vim_options', 'vim_options'],
      \ 'O' : [':Telescope oldfiles', 'oldfiles'],
      \ 'p' : [':lua require"telescope".extensions.project.project{}', 'Projects'],
      \ 'P' : [':Telescope spell_suggest', 'spell_suggest'],
      \ 's' : [':Telescope git_status', 'git_status'],
      \ 'S' : [':Telescope grep_string', 'grep_string'],
      \ 'y' : [':Telescope symbols', 'symbols'],
      \ 'Y' : [':Telescope lsp_workspace_symbols', 'lsp_workspace_symbols'],
      \ 'r' : [':Telescope registers', 'registers'],
      \ 'R' : [':Telescope reloader', 'reloader'],
      \ 'u' : [':Telescope colorscheme', 'colorschemes'],
      \ 'z' : [':Telescope current_buffer_fuzzy_find', 'buf_fuz_find'],
      \ }

" q is for quitting
let g:which_key_map.q = {
      \ 'name': '+quit',
      \ 'q': [':qall', 'Quit'],
      \ }

" h is for hopping
let g:which_key_map.h = {
      \ 'name': '+hop',
      \ 'h': [':HopWord', 'word']
      \ }

call which_key#register('<Space>', "g:which_key_map")
