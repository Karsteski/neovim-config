-- Settings for nightfox.nvim
require("nightfox").setup({
	options = {
		dim_inactive = false, -- Non focused panes set to alternative background
		transparent = false,
		terminal_colors = true,
	},
})

vim.cmd("colorscheme duskfox")
