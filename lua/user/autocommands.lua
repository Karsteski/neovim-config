local autocommand = vim.api.nvim_create_autocmd

-- Highlight Yanked Text
autocommand({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- automatically load breakpoints when a file is loaded into the buffer.
autocommand({ "BufReadPost" }, { callback = require("persistent-breakpoints.api").load_breakpoints })

