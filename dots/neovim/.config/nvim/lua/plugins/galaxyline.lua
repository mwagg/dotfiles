local gl = require('galaxyline')
local gls = gl.section

local colors = {
    bg = '#282c34',
    yellow = '#fabd2f',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#608B4E',
    orange = '#FF8800',
    purple = '#5d4d7a',
    magenta = '#d16d9e',
    grey = '#c0c0c0',
    blue = '#569CD6',
    red = '#D16969'
}

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
    return false
end

gls.left[1] = {
    GitIcon = {
        provider = function() return ' ' end,
        condition = buffer_not_empty,
        highlight = {colors.orange, colors.bg}
    }
}
gls.left[2] = {
    GitBranch = {
        provider = 'GitBranch',
        separator = ' ',
        separator_highlight = {colors.purple, colors.bg},
        condition = buffer_not_empty,
        highlight = {colors.grey, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

gls.left[3] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '  ',
        highlight = {colors.green, colors.bg}
    }
}
gls.left[4] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '  ',
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[5] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}
gls.left[6] = {
    LspClient = {
        provider = 'GetLspClient',
        condition = buffer_not_empty,
        highlight = {colors.green, colors.bg}
    }
}
gls.left[7] = {
    LeftEnd = {
        provider = function() return ' ' end,
        separator = ' ',
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.purple, colors.bg}
    }
}
gls.left[8] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red, colors.bg}
    }
}
gls.left[9] = {Space = {provider = function() return '' end}}
gls.left[10] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow, colors.bg}
    }
}
gls.left[11] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '   ',
        highlight = {colors.blue, colors.bg}
    }
}
gls.left[12] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '   ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[1] = {
    FileFormat = {
        provider = 'FileFormat',
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}
gls.right[2] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' | ',
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}
gls.right[3] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' |',
        separator_highlight = {colors.darkblue, colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}
gls.right[4] = {
    ScrollBar = {
        provider = 'ScrollBar',
        highlight = {colors.yellow, colors.purple}
    }
}
