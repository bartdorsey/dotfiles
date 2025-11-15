local wezterm = require("wezterm")

local M = {}

function M.apply_platform_config(config)
    config.window_padding = {
        left = "2cell",
        right = "2cell",
        top = "1cell",
        bottom = "1cell",
    }
    if wezterm.target_triple == "x86_64-pc-windows-msvc" then
        config.default_domain = "WSL:Ubuntu"
        -- config.front_end = "WebGpu"
        -- config.webgpu_power_preference = "HighPerformance"
        -- config.webgpu_preferred_adapter = {
        --     backend= "Dx12",
        --     device= 7812,
        --     device_type= "DiscreteGpu",
        --     driver= "32.0.15.8157",
        --     name= "NVIDIA GeForce RTX 2070 SUPER",
        --     vendor= 4318,
        -- }
        config.font = wezterm.font("Iosevka Nerd Font", { weight = "DemiBold" })
        config.font_size = 14
        config.win32_system_backdrop = "Acrylic"
        config.window_background_opacity = 0
    elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
        -- config.window_decorations = "RESIZE"
        config.enable_wayland = false
        config.kde_window_background_blur = true
        config.window_background_opacity = 0.8
        config.font_size = 14
        config.default_prog = { os.getenv("SHELL") }
        config.front_end = "WebGpu"
        config.font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" })
    else
        config.macos_window_background_blur = 80
        config.window_background_opacity = 0.8
        config.default_prog = { os.getenv("SHELL") }
        config.front_end = "WebGpu"
        config.font_size = 16
        config.font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" })
        -- macOS needs less space on bottom for some reason
        config.window_padding = {
            left = "2cell",
            right = "2cell",
            top = "1cell",
            bottom = "0cell",
        }
    end
end

return M
