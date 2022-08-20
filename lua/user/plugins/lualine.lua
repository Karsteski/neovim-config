local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
	print("There was an error in 'lualine.lua'")
	return
end

-- For debug status
local debug_status = require("dap").status()
lualine.setup({
	lualine_c = { "filename", debug_status },
})
