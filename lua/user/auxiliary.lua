-- auxiliary module

-- Capture name searched for by "required"
local NAME = ...

-- Table to hold functions for export
local M = {}

function M.isWindowsOS()
    return vim.loop.os_uname().sysname == "Windows_NT"
end

function M.isLinuxOS()
    return vim.loop.os_uname().sysname == "Linux"
end

function M.isMacOS()
    return vim.loop.os_uname().sysname == "Darwin"
end


function M.isNeovideGUI()
    -- Check if Neovide is being used
    return vim.g.neovide ~= nil
end

return M
