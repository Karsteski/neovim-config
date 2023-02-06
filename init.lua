-- Note the initial lua folder is implied, as well as .lua
require("user.plugins")
require("user.colourschemes")
require("user.options")
require("user.autocommands")
require("user.user_commands")
require("user.keymaps")

-- Plugin Configurations
require("user.plugins.bufferline")
require("user.plugins.lualine")
require("user.plugins.toggleterm")
require("user.plugins.nvim-autopairs")
require("user.plugins.nvim-tree")
require("user.plugins.nvim-treesitter")
require("user.plugins.telescope")
require("user.plugins.nvim-notify")
require("user.plugins.gitsigns")
require("user.plugins.project")
require("user.plugins.comment")
require("user.plugins.nvim-lastplace")
require("user.plugins.godbolt")
require("user.plugins.neovim-session-manager")
require("user.plugins.nvim-navic")

-- LSP and Completion
require("user.plugins.lsp.lspconfig")
require("user.plugins.lsp.null-ls")
require("user.plugins.lsp.mason")
require("user.plugins.completion")
require("user.plugins.lsp.mason-tool-installer")

-- Debugging
require("user.plugins.debugging.nvim-dap")
require("user.plugins.debugging.nvim-dap-ui")
require("user.plugins.debugging.nvim-dap-virtual-text")

-- Neovide
require("user.neovide")
