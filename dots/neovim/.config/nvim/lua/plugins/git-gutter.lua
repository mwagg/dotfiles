vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_highlight_linenrs = 1

vim.api.nvim_set_keymap('n', '[c', ':GitGutterPrevHunk<cr>',
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', ']c', ':GitGutterNextHunk<cr>',
                        {silent = true, noremap = true})

local wk = require('whichkey_setup')

local keymap = {
    g = {
        s = {':GitGutterStageHunk<cr>', 'Stage hunk'},
        u = {':GitGutterUndoHunk<cr>', 'Undo hunk'},
        p = {':GitGutterPreviewHunk<cr>', 'Preview hunk'}
    }
}

wk.register_keymap('leader', keymap)
