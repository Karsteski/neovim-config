 -- Note the initial lua folder is implied, as well as .lua
require('user.colourschemes')

require("user.options")
require("user.keymaps")
require("user.plugins")

-- Plugin Configurations
require('user.plugins.bufferline')
require('user.plugins.lualine')
require('user.plugins.mason')
require('user.plugins.lspconfig')
require('user.plugins.toggleterm')
require('user.plugins.nvim-autopairs')

