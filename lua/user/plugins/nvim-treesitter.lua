local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

ts_configs.setup({
	ensure_installed = { "c", "cpp", "python", "lua", "bash", "cmake", "gdscript", "markdown" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
        
        -- "Temp" fix for broken Python indentation
        disable = {"python"}
	},
})
