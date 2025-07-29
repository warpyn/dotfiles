local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- fonts
config.font = wezterm.font("Terminess Nerd Font Mono", {weight="Medium", stretch="Normal", style="Normal"})
-- config.font = wezterm.font("BlexMono Nerd Font Propo", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 18

-- appearance
config.color_scheme = "rose-pine"
config.force_reverse_video_cursor = true

-- windows
config.window_decorations = "RESIZE"
local horizontal_pad = 0
local vertical_pad = 10
config.window_padding = { left = horizontal_pad, right = horizontal_pad, top = vertical_pad, bottom = vertical_pad }

-- tabs
config.hide_tab_bar_if_only_one_tab = true

-- transparency and background blur
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- optimization
config.max_fps = 120
config.prefer_egl = true -- use metal in macos

return config
