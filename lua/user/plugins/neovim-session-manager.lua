local status_ok, session = pcall(require, "session_manager")
if not status_ok then
	return
end

session.setup({})
