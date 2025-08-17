local wezterm = require("wezterm")

local M = {}

function M.apply_platform_config(config)
    if wezterm.target_triple == "x86_64-pc-windows-msvc" then
        config.default_domain = "WSL:Ubuntu"
        config.front_end = "OpenGL"
        config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
        config.font_size = 14
        config.win32_system_backdrop = "Mica"
        config.window_background_opacity = 0.9
    elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
        config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
        config.enable_wayland = false
        config.kde_window_background_blur = true
        config.window_background_opacity = 0.8
        config.font_size = 14
        config.default_prog = { os.getenv("SHELL") }
        config.front_end = "WebGpu"
    else
        config.macos_window_background_blur = 80
        config.window_background_opacity = 0.8
        config.default_prog = { os.getenv("SHELL") }
        config.front_end = "WebGpu"
        config.font_size = 16
    end
end

return M
