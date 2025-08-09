local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

function M.setup_mouse_bindings(config)
    config.mouse_bindings = {
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "NONE",
            action = act.CompleteSelection("ClipboardAndPrimarySelection"),
        },
        {
            event = { Up = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = act.OpenLinkAtMouseCursor,
        },
        {
            event = { Down = { streak = 1, button = "Left" } },
            mods = "CTRL",
            action = act.Nop,
        },
    }
end

return M

