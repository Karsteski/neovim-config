local auxiliary = require("user.auxiliary")
-- Neovide supports settings via global variables w/ a neovide prefix
local opt = vim.g

-- Check if Neovide is being used
if auxiliary.isNeovideGUI() then
	opt.neovide_transparency = 0.8
	opt.neovide_cursor_vfx_mode = "pixiedust"
end
