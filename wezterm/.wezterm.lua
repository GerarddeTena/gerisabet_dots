local wezterm = require 'wezterm'
local config = {}

-- Usar la versión más moderna de la configuración
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- --- ESTÉTICA ---
config.color_scheme = 'Tokyo Night' -- Un tema muy popular para devs
config.font = wezterm.font('JetBrains Mono') -- Si no la tienes, Mint la instalará
config.font_size = 11.0
config.window_background_opacity = 0.90 -- Un toque de transparencia
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
config.font = wezterm.font('IosevkaTerm Nerd Font')
-- --- ATAJOS DE TECLADO (Keybindings) ---
-- Usaremos CTRL+SHIFT como tecla líder para no chocar con Neovim
config.keys = {
  -- Dividir pantalla horizontalmente (como en VS Code pero con teclado)
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Dividir pantalla verticalmente
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- Cerrar panel
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
}

return config
