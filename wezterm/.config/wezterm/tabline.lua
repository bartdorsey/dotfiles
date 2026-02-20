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
            tabs_enabled = true,
            theme = "GruvboxDarkHard",
            theme_overrides = {
                tab = {
                    active = { fg = "#fabd2f" },
                    inactive = { fg = "#665c54" },
                },
            },
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
            tabline_x = {
                "ram",
                "cpu",
                {
                    "datetime",
                    style = "%I:%M %p",
                },
            },
            tabline_y = {},
            tabline_z = {},
        },
        extensions = {},
    })

    tabline.apply_to_config(config)
    config.use_fancy_tab_bar = true
    -- config.show_close_tab_button_in_tabs = true
end

return M
