require("notify").setup({})

-- Allow other plugins to use the notification windows
vim.notify = require("notify")

require("notify").setup({
	background_colour = "#000000",
})

vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	vim.notify(msg, ...)
end
