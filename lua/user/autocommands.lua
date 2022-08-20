local autocommand = vim.api.nvim_create_autocmd

-- Highlight Yanked Text
autocommand({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- automatically load breakpoints when a file is loaded into the buffer.
local status_ok, pb_api = pcall(require, "persistent-breakpoints.api")
if not status_ok then
	return
end

autocommand({ "BufReadPost" }, { callback = pb_api.load_breakpoints })
