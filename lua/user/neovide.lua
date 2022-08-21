-- Neovide supports settings via global variables w/ a neovide prefix
local opt = vim.g

-- Check if Neovide is being used
if opt.neovide then
	opt.neovide_transparency = 0.6
    opt.neovide_cursor_vfx_mode = "pixiedust"
end
