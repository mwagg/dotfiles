vim.g.gitgutter_highlight_linenrs = 1

local wk = require('whichkey_setup')

local keymap = {
    g = {
        name = '+git',
        s = {':GitGutterStageHunk<cr>', 'Stage hunk'},
        u = {':GitGutterUndoHunk<cr>', 'Undo hunk'},
        p = {':GitGutterPreviewHunk<cr>', 'Preview hunk'}
    }
}

wk.register_keymap('leader', keymap)
