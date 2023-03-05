return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local alpha = require('alpha')
		local startify = require('alpha.themes.startify')
		local width = 46
		local height = 25
		startify.section.header.val = {
			"  ／l、",
			"（ﾟ､ ｡７",
			"   l、ﾞ~ヽ",
			"  じしf_,)ノ",
		}
		alpha.setup(startify.config)
	end
}
