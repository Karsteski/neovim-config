local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

if not vim.g.vscode then
	toggleterm.setup({
		float_opts = {
			border = "curved",
		},
	})
end
