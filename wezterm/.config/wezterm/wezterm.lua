local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local color_scheme = "Catppuccin Mocha"

local tabline =
    wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local domains =
    wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")

-- local tabline =
--     wezterm.plugin.require("https://github.com/bartdorsey/tabline.wez")

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
-- Read more below on the gotcha of binding an 'Up' event only.
-- end)

local opacity = 0.8
local font_size = 14
local front_end = "WebGpu"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_domain = "WSL:NixOS"
    opacity = 0.90
    font_size = 12
    front_end = "OpenGL"
    config.exec_domains = {
        wezterm.exec_domain("powershell", function(cmd)
            wezterm.log_info(cmd)
            cmd.args = { "pwsh.exe", "-NoLogo" }
            return cmd
        end),
    }
    config.launch_menu = {
        {
            label = "NixOS",
            domain = { DomainName = "WSL:NixOS" },
        },
        {
            label = "Ubuntu",
            domain = { DomainName = "WSL:Ubuntu" },
        },
        {
            label = "Powershell",
            args = { "pwsh.exe" },
            domain = { DomainName = "local" },
        },
        {
            label = "Powershell (Admin)",
            args = { "sudo.exe", "pwsh.exe" },
            domain = { DomainName = "local" },
        },
    }
else
    local shell = os.getenv("SHELL")
    config.default_prog = { shell }
    config.launch_menu = {
        {
            label = "zsh",
            args = { "zsh", "-l" },
        },
    }
end

config.set_environment_variables = {
    TERM = "wezterm",
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.4,
}

config.font_size = font_size
config.color_scheme = color_scheme
config.disable_default_key_bindings = false
config.max_fps = 170
config.cursor_thickness = "2pt"
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.force_reverse_video_cursor = false
config.initial_rows = 35
config.initial_cols = 100
config.audible_bell = "Disabled"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = opacity
config.macos_window_background_blur = 80
config.adjust_window_size_when_changing_font_size = false
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.harfbuzz_features = nil
config.command_palette_bg_color = "#000000"
config.command_palette_fg_color = "#FFFFFF"
config.command_palette_font_size = 16.0
config.command_palette_rows = 1
config.status_update_interval = 1000
config.front_end = front_end
config.unix_domains = {
    {
        name = "unix",
    },
}
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }
config.keys = {
    {
        key = "E",
        mods = "CTRL",
        action = wezterm.action.EmitEvent("toggle-ligature"),
    },
    {
        key = " ",
        mods = "LEADER",
        action = wezterm.action.ShowLauncherArgs({
            flags = "LAUNCH_MENU_ITEMS",
        }),
    },
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    {
        key = "b",
        mods = "LEADER",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "\\",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({
            domain = "CurrentPaneDomain",
        }),
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "r",
        mods = "LEADER",
        action = wezterm.action.ReloadConfiguration,
    },
    {
        key = "h",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        key = "x",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = "d",
        mods = "LEADER",
        action = wezterm.action.DetachDomain("CurrentPaneDomain"),
    },
}

for i = 1, 9 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

config.mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },

    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
    -- NOTE that binding only the 'Up' event can give unexpected behaviors.
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.Nop,
    },
}

tabline.setup({
    options = {
        icons_enabled = true,
        theme = "Catppuccin Mocha",
        tabs_enabled = true,
        theme_overrides = {},
        section_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
        component_separators = {
            left = wezterm.nerdfonts.pl_left_soft_divider,
            right = wezterm.nerdfonts.pl_right_soft_divider,
        },
        tab_separators = {
            left = wezterm.nerdfonts.pl_left_hard_divider,
            right = wezterm.nerdfonts.pl_right_hard_divider,
        },
    },
    sections = {
        tabline_a = { "mode" },
        tabline_b = { "" },
        tabline_c = { "" },
        tab_active = {
            {
                "index",
                padding = 0,
                fmt = function(string)
                    return string .. " "
                end,
            },
            { "zoomed", padding = 0 },
            {
                "process",
                process_to_icon = {
                    ["lg"] = wezterm.nerdfonts.dev_git,
                    ["lazygit"] = wezterm.nerdfonts.dev_git,
                },
            },
        },
        tab_inactive = {
            {
                "index",
                padding = 0,
                fmt = function(string)
                    return string .. " "
                end,
            },
            { "zoomed", padding = 0 },
            { "process" },
        },
        tabline_x = { "ram", "cpu" },
        tabline_y = {
            {
                "datetime",
                style = "%I:%M %p",
            },
        },
        tabline_z = {
            "hostname",
        },
    },
    extensions = {
        "quick_domains",
    },
})

domains.apply_to_config(config, {
    keys = {
        -- open domain in new tab
        attach = {
            -- mod keys for fuzzy domain finder
            mods = "LEADER",
            -- base key for fuzzy domain finder
            key = "d",
            -- key table to insert key map to if any
            tbl = "",
        },
        -- add remote domains as exec domain for split binds
        vsplit = {
            key = "v",
            mods = "LEADER",
            tbl = "",
        },
        hsplit = {
            key = "h",
            mods = "LEADER",
            tbl = "",
        },
    },
    auto = {
        -- disable ssh multiplex auto config
        ssh_ignore = true,
        -- disable exec domain auto configs
        exec_ignore = {
            ssh = true,
            docker = true,
            kubernetes = true,
        },
    },
})
tabline.apply_to_config(config)

config.window_decorations = "TITLE | RESIZE"

return config
