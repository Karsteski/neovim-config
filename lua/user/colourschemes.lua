-- Settings for nightfox.nvim
require("nightfox").setup({
	options = {
		dim_inactive = true, -- Non focused panes set to alternative background
		transparent = true,
        terminal_colors = true,
	},
})

vim.cmd("colorscheme duskfox")
