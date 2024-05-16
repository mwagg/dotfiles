---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local maps = opts.mappings
    local astro = require "astrocore"

    if vim.fn.executable "irb" == 1 then
      maps.n["<Leader>ti"] = { function() astro.toggle_term_cmd "irb" end, desc = "ToggleTerm Ruby irb" }
    end

    if vim.fn.executable "./bin/rails" == 1 then
      maps.n["<Leader>tr"] =
        { function() astro.toggle_term_cmd "bundle exec rails console" end, desc = "ToggleTerm rails console" }
    end
  end,
}
