local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
	print("There was an error in 'lualine.lua'")
	return
end

-- For debug status
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local debug_status = dap.status()

lualine.setup({
	-- lualine_c = { "filename", debug_status },
})
