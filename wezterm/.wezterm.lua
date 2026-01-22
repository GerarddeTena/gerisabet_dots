local wezterm = require("wezterm")
local config = {}

-- Usar la versión más moderna de la configuración
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- --- ESTÉTICA ---
config.font_size = 12.0
config.window_background_opacity = 1
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
config.font = wezterm.font("IosevkaTerm Nerd Font")
config.default_prog = { "/usr/bin/env", "fish", "-l" }
config.colors = {
	background = "#0D0C0C",
	foreground = "#C5C9C5",
	cursor_bg = "#C8C093",
	cursor_fg = "#0D0C0C",
	cursor_border = "#C8C093",
	selection_bg = "#8BA4B0",
	selection_fg = "#0D0C0C",

	split = "#A6A69C",
	scrollbar_thumb = "#434343",
	compose_cursor = "#E6C384",

	ansi = {
		"#0D0C0C",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#C8C093",
	},
	brights = {
		"#A6A69C",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C5",
	},
}
return config
