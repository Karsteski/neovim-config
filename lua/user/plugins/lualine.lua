local status_ok, lualine = pcall(require, "lualine")
local nvim_navic_status_ok, nvim_navic = pcall(require, "nvim-navic")

if not status_ok and not nvim_navic_status_ok then
	print("There was an error in 'lualine.lua'")
	return
end

lualine.setup({
    options = {
        theme = "palenight",
    },
    extensions = {
        "lazy",
        "nvim-dap-ui",
        "nvim-tree",
        "toggleterm"
    }
})
