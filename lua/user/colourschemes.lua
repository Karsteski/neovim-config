-- Settings for nightfox.nvim
require("nightfox").setup({
	options = {
		dim_inactive = true, -- Non focused panes set to alternative background
		transparent = true,
	},
})

vim.cmd("colorscheme nightfox")

-- Settings for solarized.nvim
-- vim.g.solarized_borders = true
-- require('solarized').set()
