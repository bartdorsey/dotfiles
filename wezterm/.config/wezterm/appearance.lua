local wezterm = require("wezterm")

local M = {}

function M.apply_appearance_config(config)
    config.color_scheme = "Catppuccin Mocha"

    config.set_environment_variables = {
        TERM = "wezterm",
    }

    config.inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.4,
    }

    config.cursor_thickness = "2pt"
    config.cursor_blink_rate = 600
    config.cursor_blink_ease_in = "Constant"
    config.cursor_blink_ease_out = "Constant"
    config.force_reverse_video_cursor = false

    config.initial_rows = 35
    config.initial_cols = 100
    config.max_fps = 170

    config.disable_default_key_bindings = false
    config.audible_bell = "Disabled"
    config.enable_tab_bar = true
    config.tab_bar_at_bottom = false
    config.warn_about_missing_glyphs = false
    config.window_close_confirmation = "NeverPrompt"
    config.adjust_window_size_when_changing_font_size = false
    config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
    config.harfbuzz_features = nil

    config.command_palette_bg_color = "#1e1e2e"
    config.command_palette_fg_color = "#cdd6f4"
    config.command_palette_font_size = 16.0
    config.command_palette_font = wezterm.font("JetBrains Mono")
    config.char_select_bg_color = "#313244"
    config.char_select_fg_color = "#cdd6f4"

    config.status_update_interval = 1000
    config.unix_domains = { { name = "unix" } }
end

return M

