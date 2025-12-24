local wezterm = require("wezterm")

local config = wezterm.config_builder and wezterm.config_builder() or {}

local events = require("events")
local domains = require("domains")
local platform = require("platform")
local appearance = require("appearance")
local keybindings = require("keybindings")
local mouse = require("mouse")
local tabline = require("tabline")

events.setup()

appearance.apply_appearance_config(config)
keybindings.setup_keybindings(config, domains)
mouse.setup_mouse_bindings(config)
tabline.setup_tabline(config)
platform.apply_platform_config(config)

config.ssh_domains = domains.get_ssh_domains()

return config
