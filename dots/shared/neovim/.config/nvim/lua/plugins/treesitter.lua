require'nvim-treesitter.configs'.setup {
    ensure_installed = {"bash", "python", "typescript"},
    highlight = {
        enable = true
    },
    autotag = {enable = true},
    rainbow = {enable = true}
}
