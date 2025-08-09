local wezterm = require("wezterm")

local M = {}

local function get_ssh_hosts()
    local filtered_hosts = {}

    for host, _ in pairs(wezterm.enumerate_ssh_hosts()) do
        if not host:match("[%*%?]") then
            table.insert(filtered_hosts, {
                hostname = host,
                domain_name = "SSH:" .. host,
            })
        end
    end

    return filtered_hosts
end

local function get_domain_entries()
    local entries = {}

    if wezterm.target_triple == "x86_64-pc-windows-msvc" then
        table.insert(entries, {
            label = wezterm.nerdfonts.md_powershell .. " Powershell",
            args = { "pwsh.exe", "-NoLogo" },
            domain = { DomainName = "local" },
        })
        table.insert(entries, {
            label = wezterm.nerdfonts.md_shield_crown .. " Powershell (Admin)",
            args = { "sudo.exe", "pwsh.exe", "-NoLogo" },
            domain = { DomainName = "local" },
        })

        for _, wsl_domain in ipairs(wezterm.default_wsl_domains()) do
            table.insert(entries, {
                label = wezterm.nerdfonts.linux_tux .. " " .. wsl_domain.name,
                args = {},
                domain = { DomainName = wsl_domain.name },
            })
        end
    else
        table.insert(entries, {
            label = wezterm.nerdfonts.dev_terminal .. " zsh",
            args = { "zsh", "-l" },
            domain = { DomainName = "local" },
        })
        table.insert(entries, {
            label = wezterm.nerdfonts.dev_terminal_cmd .. " bash",
            args = { "bash", "-l" },
            domain = { DomainName = "local" },
        })
    end

    for _, ssh_host in ipairs(get_ssh_hosts()) do
        table.insert(entries, {
            label = wezterm.nerdfonts.fa_server .. " " .. ssh_host.hostname,
            args = {},
            domain = { DomainName = ssh_host.domain_name },
        })
    end

    return entries
end

local function get_ssh_domains()
    local ssh_domains = {}

    for _, ssh_host in ipairs(get_ssh_hosts()) do
        table.insert(ssh_domains, {
            name = ssh_host.domain_name,
            remote_address = ssh_host.hostname,
            multiplexing = "None",
        })
    end

    return ssh_domains
end

function M.create_split_selector(direction)
    local entries = get_domain_entries()
    local choices = {}

    for i, entry in ipairs(entries) do
        table.insert(choices, {
            id = tostring(i),
            label = entry.label,
        })
    end

    return {
        title = direction == "horizontal" and "Split Horizontal"
            or "Split Vertical",
        choices = choices,
        fuzzy = true,
        action = wezterm.action_callback(function(window, pane, id)
            local entry = entries[tonumber(id)]
            if entry then
                local action = direction == "horizontal"
                        and wezterm.action.SplitHorizontal({
                            domain = entry.domain,
                            args = entry.args,
                        })
                    or wezterm.action.SplitVertical({
                        domain = entry.domain,
                        args = entry.args,
                    })
                window:perform_action(action, pane)
            end
        end),
    }
end

function M.get_launch_menu()
    return get_domain_entries()
end

function M.get_ssh_domains()
    return get_ssh_domains()
end

return M

