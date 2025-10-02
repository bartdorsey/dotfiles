local wezterm = require("wezterm")

local M = {}

function M.setup_tabline(config)
    local tabline = wezterm.plugin.require(
        "https://github.com/michaelbrusegard/tabline.wez"
    )

    local tab_config = {
        {
            "index",
            padding = 0,
        },
        {
            "process",
            process_to_icon = {
                ["lg"] = wezterm.nerdfonts.dev_git,
                ["lazygit"] = wezterm.nerdfonts.dev_git,
            },
        },
        {
            "cwd",
            icon = wezterm.nerdfonts.cod_folder,
            padding = 0,
            max_length = 10,
        },
    }
    tabline.setup({
        options = {
            icons_enabled = true,
            icons_only = false,
            theme = "GruvboxDark",
            tabs_enabled = true,
            theme_overrides = {},
            section_separators = {
                left = " ",
                right = " ",
            },
            component_separators = {
                left = " ",
                right = " ",
            },
            tab_separators = {
                left = " ",
                right = " ",
            },
        },
        sections = {
            tabline_a = { "" },
            tabline_b = { "" },
            tabline_c = { "" },
            tab_active = tab_config,
            tab_inactive = tab_config,
            tabline_x = { "ram", "cpu" },
            tabline_y = { { "datetime", style = "%I:%M %p" } },
            tabline_z = {},
        },
        extensions = {},
    })

    tabline.apply_to_config(config)
    config.use_fancy_tab_bar = false

    config.window_padding = {
        left = "2cell",
        right = "2cell",
        top = "1cell",
        bottom = "1cell",
    }
end

return M
