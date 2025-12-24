local wezterm = require("wezterm")

local M = {}

function M.get_ssh_hosts()
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

function M.get_launch_menu(pane)
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
        local current_domain = pane:get_domain_name()
        for _, wsl_domain in ipairs(wezterm.default_wsl_domains()) do
            local cwd = "~"
            if current_domain == wsl_domain.name then
                cwd = nil
            end
            wezterm.log_error(cwd)
            table.insert(entries, {
                label = wezterm.nerdfonts.linux_tux .. " " .. wsl_domain.name,
                args = {},
                domain = { DomainName = wsl_domain.name },
                cwd = cwd,
            })
        end
    else
        table.insert(entries, {
            label = wezterm.nerdfonts.dev_terminal .. " zsh",
            args = { "zsh", "-l" },
            domain = { DomainName = "local" },
        })
        table.insert(entries, {
            label = wezterm.nerdfonts.dev_terminal .. " bash",
            args = { "bash", "-l" },
            domain = { DomainName = "local" },
        })
    end

    for _, ssh_host in ipairs(M.get_ssh_hosts()) do
        table.insert(entries, {
            label = wezterm.nerdfonts.fa_server .. " " .. ssh_host.hostname,
            args = {},
            domain = { DomainName = ssh_host.domain_name },
        })
    end

    return entries
end

function M.get_ssh_domains()
    local ssh_domains = {}

    for _, ssh_host in ipairs(M.get_ssh_hosts()) do
        table.insert(ssh_domains, {
            name = ssh_host.domain_name,
            remote_address = ssh_host.hostname,
            multiplexing = "None",
        })
    end

    return ssh_domains
end

function M.create_selector(type, pane)
    local entries = M.get_launch_menu(pane)
    local choices = {}

    for i, entry in ipairs(entries) do
        table.insert(choices, {
            id = tostring(i),
            label = entry.label,
        })
    end

    return {
        title = type == "horizontal" and "Split Horizontal" or "Split Vertical",
        choices = choices,
        fuzzy = true,
        action = wezterm.action_callback(function(window, pane, id)
            local entry = entries[tonumber(id)]
            if entry then
                local spawn_config = {
                    domain = entry.domain,
                    args = entry.args,
                    cwd = entry.cwd,
                }
                if type == "horizontal" then
                    window:perform_action(
                        wezterm.action.SplitHorizontal(spawn_config),
                        pane
                    )
                elseif type == "vertical" then
                    window:perform_action(
                        wezterm.action.SplitVertical(spawn_config),
                        pane
                    )
                elseif type == "tab" then
                    window:perform_action(
                        wezterm.action.SpawnCommandInNewTab(spawn_config),
                        pane
                    )
                else
                    return
                end
            end
        end),
    }
end

return M
