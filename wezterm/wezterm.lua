local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 16
config.color_scheme = 'tokyonight'
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true

return config
