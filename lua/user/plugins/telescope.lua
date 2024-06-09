require("user.keymaps")
local auxiliary = require("user.auxiliary")

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
	},
    mappings = TELESCOPE_DEFAULT_MAPPINGS
})

if (auxiliary.isLinuxOS()) then
    -- For faster Telescope sorting 
    -- telescope.load_extension('fzf')
end

-- For line wrapping in the previewer 
vim.cmd( [[autocmd User TelescopePreviewerLoaded setlocal wrap]] )
