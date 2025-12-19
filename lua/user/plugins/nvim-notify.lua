local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

max_timeout = 1.5

-- Allow other plugins to use the notification windows
vim.notify = function (msg, level, opts)
    opts = opts
    opts.timeout = math.max(opts.timeout or max_timeout, max_timeout)
    notify.notify(msg, level, opts)end
