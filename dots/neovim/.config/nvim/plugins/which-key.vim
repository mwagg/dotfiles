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
let g:which_key_map['.'] = [':e $MYVIMRC', 'Open init']
let g:which_key_map['='] = ['<C-W>=', 'Balance windows']
let g:which_key_map[' '] = [':Telescope find_files hidden=true', 'Find files']

" g is for git
let g:which_key_map.g = {
      \ 'name': '+git',
      \ 'g': [':Neogit', 'Show Neogit'],
      \ 'm': [':GitMessenger', 'Git message'],
      \ }

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
      \ 'r': [':Lspsaga rename', 'Signature help'],
      \ 'd': [':Lspsaga preview_definition', 'Preview definition'],
      \ 'e': [':Lspsaga show_line_diagnostics', 'Show line diagnostics'],
      \ 'a': [':Lspsaga code_action', 'Code actions'],
      \ }

" b is for buffers
let g:which_key_map.b = {
      \ 'b' : [':Telescope buffers', 'Buffers'],
      \ 'd' : [':BufferClose', 'Close buffer'],
      \}

" s is for search powered by telescope
let g:which_key_map.s = {
      \ 'name' : '+search',
      \ '.' : [':Telescope filetypes', 'filetypes'],
      \ ';' : [':Telescope commands', 'commands'],
      \ 'a' : [':Telescope lsp_code_actions', 'code_actions'],
      \ 'A' : [':Telescope builtin', 'all'],
      \ 'b' : [':Telescope buffers', 'buffers'],
      \ 'B' : [':Telescope git_branches', 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics', 'document_diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace_diagnostics'],
      \ 'c' : [':Telescope git_commits', 'git_commits'],
      \ 'C' : [':Telescope git_bcommits', 'git_bcommits'],
      \ 'f' : [':Telescope find_files', 'files'],
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
      \ 'p' : [':Telescope fd', 'fd'],
      \ 'P' : [':Telescope spell_suggest', 'spell_suggest'],
      \ 's' : [':Telescope git_status', 'git_status'],
      \ 'S' : [':Telescope grep_string', 'grep_string'],
      \ 't' : [':Telescope live_grep', 'text'],
      \ 'y' : [':Telescope symbols', 'symbols'],
      \ 'Y' : [':Telescope lsp_workspace_symbols', 'lsp_workspace_symbols'],
      \ 'r' : [':Telescope registers', 'registers'],
      \ 'R' : [':Telescope reloader', 'reloader'],
      \ 'w' : [':Telescope file_browser', 'buf_fuz_find'],
      \ 'u' : [':Telescope colorscheme', 'colorschemes'],
      \ 'z' : [':Telescope current_buffer_fuzzy_find', 'buf_fuz_find'],
      \ }

" q is for quitting
let g:which_key_map.q = {
      \ 'name': '+quit',
      \ 'q': [':qall', 'Quit'],
      \ }

call which_key#register('<Space>', "g:which_key_map")
