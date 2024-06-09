local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
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
