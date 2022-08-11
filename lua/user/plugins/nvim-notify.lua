require('notify').setup({})

-- Allow other plugins to use the notification windows
vim.notify = require('notify')
