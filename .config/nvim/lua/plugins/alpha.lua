return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons', 'Shatur/neovim-session-manager' },
	config = function()
		local alpha = require('alpha')
		local startify = require('alpha.themes.startify')
		startify.section.header.val = {
			"  ／l、",
			"（ﾟ､ ｡７",
			"   l、ﾞ~ヽ",
			"  じしf_,)ノ",
		}
		alpha.setup(startify.config)
	end
}
