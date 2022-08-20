local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({})

-- Allow other plugins to use the notification windows
vim.notify = notify

notify.setup({
	background_colour = "#000000",
})

-- TODO: Update this. There's a reddit comment with a better fix. Causes a stack overflow error on some notifications
--[[ vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    vim.notify(msg, ...)
end ]]
