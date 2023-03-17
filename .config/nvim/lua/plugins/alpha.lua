return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'kdheepak/lazygit.nvim' },
    config = function()
        local alpha = require('alpha')
        local theta = require('alpha.themes.theta')
        local dashboard = require('alpha.themes.dashboard')
        theta.buttons.val = {
        dashboard.button("e", " " .. " New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", " " .. " Find Files", ":Telescope find_files<cr>"),
        dashboard.button("g", " " .. " Find Git Files", ":Telescope git_files<cr>"),
        dashboard.button("G", " " .. " Lazy Git", ":LazyGit<cr>"),
        dashboard.button("o", " " .. " Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("r", " " .. " Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
        dashboard.button("m", "󰣪 " .. " Mason", ":Mason<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),

        }
        theta.header.val = {
            "  ／l、",
            "（ﾟ､ ｡７",
            "   l、ﾞ~ヽ",
            "  じしf_,)ノ",
        }
        alpha.setup(theta.config)
    end
}
