return {
  {
    "NeogitOrg/neogit",
    lazy = true, -- lazy load on module
    dependencies = {
      { -- AstroCore is always loaded on startup, so making it a dependency doesn't matter
        "AstroNvim/astrocore",
        opts = {
          mappings = { -- define a mapping to load the plugin module
            n = {
              ["<Leader>gg"] = { function() require("neogit").open() end, desc = "Open Neogit" },
            },
          },
        },
      },
    },
    opts = {}, -- run `require("neogit").setup({})`
  },
}
