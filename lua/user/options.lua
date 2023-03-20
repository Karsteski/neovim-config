local auxiliary = require("user.auxiliary")
-- :help options

vim.opt.shortmess:append("c") -- Interprets "word-word" as a single word

--stylua: ignore
local options = {
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    backup = false,                          -- creates a backup file
    cmdheight = 2,                           -- more space in the neovim command line for displaying messages
    completeopt = {"menu", "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                         -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = true,                             -- display lines as one long line
    scrolloff = 8,                           -- is one of my fav
    sidescrolloff = 8,
    guifont = "JetBrainsMono Nerd Font Mono Bold Italic:h27",               -- the font used in graphical neovim applications
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- Run vimscript as a string
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])


-- Completion and diagnostics
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	update_in_insert = true,
	underline = true,

	float = {
		focusable = false,
		border = "rounded",
		source = "always",
		style = "minimal",
		header = "",
		prefix = "",
	},
	signs = {
		active = signs,
	},
})

-- GUI Adjustments
if (auxiliary.isNeovideGUI()) then
    -- Change separator colour from default (nvim-navic plugin)
    vim.api.nvim_set_hl(0, "NavicSeparator", {default = false, bg = "bg", fg = "#ffffff"})
end

-- Windows Adjustments
if (auxiliary.isWindowsOS()) then
    -- Needs bash on PATH
    -- Those extra outer-level square brackets are necessary on Windows...
    -- vim.o.shell = [==["C:/Program Files/Git/bin/bash.exe" -i -l]==]
    -- vim.o.shell = vim.fn.executable"powershell"
end

-- Current code context
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
