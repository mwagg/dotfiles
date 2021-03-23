local eslintSettings = {
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true,
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true
}

require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript',
        'typescriptreact', 'typescript.tsx', 'python', 'lua'
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            javascript = {eslintSettings},
            javascriptreact = {eslintSettings},
            ["javascript.jsx"] = {eslintSettings},
            typescript = {eslintSettings},
            ["typescript.tsx"] = {eslintSettings},
            typescriptreact = {eslintSettings},
            python = {
                {
                    formatCommand = 'black --quiet -',
                    formatStdin = true,
                    lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
                    lintStdin = true,
                    lintFormats = {'%f:%l:%c: %m'}
                }
            },
            lua = {{formatCommand = "lua-format -i", formatStdin = true}}
        }
    }
}
