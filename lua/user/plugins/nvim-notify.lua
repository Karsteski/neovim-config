local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

notify.setup({
    timeout = 2000,
})

-- Allow other plugins to use the notification windows
vim.notify = notify
