local wezterm = require("wezterm")

wezterm.on("toggle-ligature", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.harfbuzz_features then
        -- If we haven't overridden it yet, then override with ligatures disabled
        overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
    else
        -- else we did already, and we should disable out override now
        overrides.harfbuzz_features = nil
    end
    window:set_config_overrides(overrides)
end)

-- wezterm.on("window-focus-changed", function()
--     os.execute(
--         "xdotool search -classname org.wezfurlong.wezterm | xargs -I{} xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id {}"
--     )
-- end)

wezterm.on("toggle-opacity", function(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 0.75
    else
        overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
end)

return {
    color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
    font = wezterm.font("IosevkaTerm Nerd Font"),
    font_size = 14,
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    window_background_opacity = 0.80,
    warn_about_missing_glyphs = false,
    window_close_confirmation = "NeverPrompt",
    macos_window_background_blur = 80,
    harfbuzz_features = nil,
    unix_domains = {
        {
            name = "unix",
        },
    },
    keys = {
        {
            key = "E",
            mods = "CTRL",
            action = wezterm.action.EmitEvent("toggle-ligature"),
        },
        {
            key = "B",
            mods = "CTRL",
            action = wezterm.action.EmitEvent("toggle-opacity"),
        },
    },
}
