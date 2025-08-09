local wezterm = require("wezterm")

local M = {}

function M.setup()
    wezterm.on("toggle-ligature", function(window, _)
        local overrides = window:get_config_overrides() or {}
        if not overrides.harfbuzz_features then
            overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
        else
            overrides.harfbuzz_features = nil
        end
        window:set_config_overrides(overrides)
    end)
end

return M

