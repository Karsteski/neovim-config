local useTransparency = true

-- Neovide is prettier without transparency
if vim.g.neovide then
	useTransparency = false
end

-- Settings for nightfox.nvim
require("nightfox").setup({
	options = {
		dim_inactive = false, -- Non focused panes set to alternative background
		transparent = useTransparency,
		terminal_colors = true,
	},
})

vim.cmd("colorscheme duskfox")
