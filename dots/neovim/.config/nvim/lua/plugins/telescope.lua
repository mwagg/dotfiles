local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case', '--hidden'
        },
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default + actions.center,
                ["<esc>"] = actions.close
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            }
        }
    }
}

local wk = require('whichkey_setup')

local keymap = {
    g = {
        b = {':Telescope git_branches<cr>', 'Branches'},
        c = {':Telescope git_commits<cr>', 'Git commits'}
    }
}

wk.register_keymap('leader', keymap)
