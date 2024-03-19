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

local shell = os.getenv("SHELL")
local default_program = { shell }
local font =
    wezterm.font_with_fallback({ "Monaspace Neon", "IosevkaTerm Nerd Font" })

local opacity = 0.8

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    default_program = { "wsl", "-d", "Arch", "--cd", "~" }
    opacity = 0.90
end

return {
    set_environment_variables = {
        TERM = "wezterm",
    },
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    font_size = 12,
    max_fps = 170,
    cursor_thickness = "2pt",
    cursor_blink_rate = 600,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    force_reverse_video_cursor = false,
    initial_rows = 35,
    initial_cols = 100,
    default_prog = default_program,
    audible_bell = "Disabled",
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    warn_about_missing_glyphs = false,
    window_close_confirmation = "NeverPrompt",
    window_background_opacity = opacity,
    macos_window_background_blur = 80,
    win32_system_backdrop = "Acrylic",
    adjust_window_size_when_changing_font_size = false,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    harfbuzz_features = nil,
    command_palette_bg_color = "#000000",
    command_palette_fg_color = "#FFFFFF",
    command_palette_font_size = 16.0,
    command_palette_rows = 1,
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
    },
}
