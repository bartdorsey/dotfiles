local neovim = {
    [[⠀⠀⠀⢀⡴⣂⠀⠀⠀⠀⠀⠀⠀⠀⢰⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⢀⡴⣏⣷⡹⣆⡀⠀⠀⠀⠀⠀⠀⢸⣯⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⣴⣻⣽⣻⣼⢳⡹⣖⡄⠀⠀⠀⠀⠀⢸⣷⢿⣾⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[⣯⢷⣻⢷⣯⢳⡝⡾⣜⡆⠀⠀⠀⠀⢸⣿⡿⣯⣿⡇⠀⠀⠀⠀⠀⢀⡀⠀⣀⣤⣤⣀⠀⠀⠀⠀⠀⣀⣤⣤⣀⡀⠀⠀⠀⠀⢀⣠⣤⣤⣀⡀⠀⢠⣤⣤⠀⠀⠀⠀⢀⣤⣤⡄⣤⣤⠀⢠⣤⡄⣠⣤⣶⣤⡀⢀⣠⣴⣶⣤⣄⠀]],
    [[⣿⢯⣟⣯⣿⢣⡿⣱⢯⡞⣧⠀⠀⠀⢸⣿⣿⣿⡿⡇⠀⠀⠀⠀⠀⢸⡷⠋⠁⠀⠀⠙⣷⠀⠀⣠⠟⠁⠀⠀⠀⠙⣦⠀⢀⡾⠋⠁⠀⠀⠉⠻⣆⠈⣿⣿⣇⠀⠀⠀⣼⣿⡟⠀⣿⣿⠀⢸⣿⣿⠟⠋⠛⢿⣿⣾⠟⠋⠛⢿⣿⣧]],
    [[⣿⣟⣯⣿⣾⠈⢳⢯⡷⣛⣾⢳⡀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣹⡆⢠⣿⣤⣤⣤⣤⣤⣤⣼⡄⣼⠇⠀⠀⠀⠀⠀⠀⢿⡆⠘⣿⣿⡄⠀⢰⣿⡿⠁⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿]],
    [[⣿⡿⣯⣷⣿⠀⠀⠫⣽⣻⡼⣯⣟⣄⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢼⡇⠸⣧⠀⠀⠀⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠹⣿⣷⢠⣿⣿⠃⠀⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿]],
    [[⣿⣿⣿⣿⣿⠀⠀⠀⠑⣯⢷⣻⢾⡽⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢺⡇⠀⢻⣄⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⠀⠀⠀⠀⢠⡿⠁⠀⠀⢻⣿⣿⣿⠇⠀⠀⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿⠀⠀⠀⢸⣿⣿]],
    [[⣿⣿⣿⣿⣾⠀⠀⠀⠀⠈⢿⡽⣯⢿⣽⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠸⠇⠀⠀⠀⠀⠀⠹⠇⠀⠀⠙⠳⠦⠤⠴⠞⠋⠀⠀⠈⠳⠦⠤⠤⠶⠋⠁⠀⠀⠀⠀⠿⠿⠏⠀⠀⠀⠀⠿⠿⠀⠸⠿⠿⠀⠀⠀⠸⠿⠿⠀⠀⠀⠸⠿⠿]],
    [[⢿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠈⢻⣽⣻⣾⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠙⢿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠹⣷⢿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⠀⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}

local sharp = {
    [[                                                                       ]],
    [[                                                                     ]],
    [[       ████ ██████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      █████████ ███████████████████ ███   ███████████   ]],
    [[     █████████  ███    █████████████ █████ ██████████████   ]],
    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    [[                                                                       ]],
}

local aot = {
    [[⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⡄⠀⠀]],
    [[⢰⠒⠒⢻⣿⣶⡒⠒⠒⠒⠒⠒⠒⠒⠒⠒⡶⠊⣰⣓⡒⡆]],
    [[⢸⢸⢻⣭⡙⢿⣿⣍⡉⠉⡇⣯⠉⠉⣩⠋⢀⣔⠕⢫⡇⡇]],
    [[⢸⢸⣈⡻⣿⣶⣽⡸⣿⣦⡇⣧⠠⠊⣸⢶⠋⢁⡤⠧⡧⡇]],
    [[⢸⢸⠻⣿⣶⣝⠛⣿⣮⢻⠟⣏⣠⠞⠁⣼⡶⠋⢀⣴⡇⡇]],
    [[⢸⢸⣿⣶⣍⠻⠼⣮⡕⢁⡤⢿⢁⡴⠊⣸⣵⠞⠋⢠⡇⡇]],
    [[⢸⢘⣛⡻⣿⣧⢳⣿⣧⠎⢀⣾⠋⡠⠞⢱⢇⣠⡴⠟⡇⡇]],
    [[⢸⢸⠹⣿⣷⣎⣉⣻⢁⡔⢁⢿⡏⢀⣤⢾⡟⠁⣀⣎⡇⡇]],
    [[⢸⢸⠲⣶⣭⡛⠚⢿⢋⡔⢁⣼⠟⢋⣠⣼⠖⠋⢁⠎⡇⡇]],
    [[⢸⢸⢤⣬⣛⠿⠞⣿⢋⠔⣉⣾⠖⠋⢁⣯⡴⠞⢃⠂⡇⡇]],
    [[⢸⢸⠀⢙⣻⢿⣧⣾⡵⠚⣉⣯⠶⠛⣹⣧⠤⢮⠁⠀⡇⡇]],
    [[⠸⣘⠢⣄⠙⠿⢷⡡⠖⣋⣽⠥⠒⣩⣟⣤⣔⣁⡤⠖⣃⠇]],
    [[⠀⠀⠙⠢⢍⣻⡿⠒⢉⣴⣗⣚⣽⣋⣀⣤⣊⠥⠒⠉⠀⠀]],
    [[⠀⠀⠀⢀⣔⠥⠒⢮⣙⠾⠀⠷⣚⡭⠞⠉⠛⠦⣀⠀⠀⠀]],
    [[⠀⠀⠀⠉⠀⠀⠀⠀⠈⠑⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}

local catppuccin = {
    "  ／l、",
    "（ﾟ､ ｡７",
    "   l、ﾞ~ヽ",
    "  じしf_,)ノ",
}

return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local theta = require("alpha.themes.theta")
        local startify = require("alpha.themes.startify")
        local dashboard = require("alpha.themes.dashboard")
        local art = { neovim, sharp, aot }
        math.randomseed(os.time())
        local logo = art[math.random(#art)]
        startify.section.header.val = neovim
        alpha.setup(startify.config)
    end,
}
