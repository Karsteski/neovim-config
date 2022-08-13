require('notify').setup({})

-- Allow other plugins to use the notification windows
vim.notify = require('notify')

require('notify').setup({
    background_colour = "#000000"
})
