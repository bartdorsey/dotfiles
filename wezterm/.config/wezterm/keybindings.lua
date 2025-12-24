local wezterm = require("wezterm")

local M = {}

function M.setup_keybindings(config, domains)
    config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }

    config.keys = {
        {
            key = "E",
            mods = "CTRL",
            action = wezterm.action.EmitEvent("toggle-ligature"),
        },

        {
            key = "c",
            mods = "LEADER",
            -- action = wezterm.action.ShowLauncherArgs({
            --     flags = "LAUNCH_MENU_ITEMS|FUZZY",
            -- }),
            action = wezterm.action_callback(function(window, pane)
                window:perform_action(
                    wezterm.action.InputSelector(
                        domains.create_selector("tab", pane)
                    ),
                    pane
                )
            end),
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
            action = wezterm.action_callback(function(window, pane)
                window:perform_action(
                    wezterm.action.InputSelector(
                        domains.create_selector("horizontal", pane)
                    ),
                    pane
                )
            end),
        },
        {
            key = "-",
            mods = "LEADER",
            action = wezterm.action_callback(function(window, pane)
                window:perform_action(
                    wezterm.action.InputSelector(
                        domains.create_selector("vertical", pane)
                    ),
                    pane
                )
            end),
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
    }

    for i = 1, 9 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "LEADER",
            action = wezterm.action.ActivateTab(i - 1),
        })
    end
end

return M
