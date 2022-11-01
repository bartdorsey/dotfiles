vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'gruvbox-community/gruvbox'
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'ryanoasis/vim-devicons'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    use 'airblade/vim-gitgutter'
    use 'preservim/nerdcommenter'
    use 'nvim-treesitter/nvim-treesitter'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'romgrk/barbar.nvim'
    use 'catppuccin/nvim'
    use 'ghifarit53/tokyonight-vim'
end)

