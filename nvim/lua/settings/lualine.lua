local use = require("packer").use

use {
    "nvim-lualine/lualine.nvim",
    requires = {"kyazdani42/nvim-web-devicons", "SmiteshP/nvim-gps", opt = true},
    config = function()
        local gps = require("nvim-gps")

        gps.setup()

        -- Returns a string with context information
        require("lualine").setup {
            options = {theme = "nightfox"},
            sections = {
                lualine_a = {"mode"},
                lualine_b = {"branch", "diff", "diagnostics"},
                lualine_c = {"filename", {gps.get_location, cond = gps.is_available}},
                lualine_x = {"encoding", "fileformat", "filetype"},
                lualine_y = {"progress"},
                lualine_z = {"location"}
            }
        }
    end
}
