local status_ok, godbolt = pcall(require, "godbolt")
if not status_ok then
	return
end

-- Default settings
godbolt.setup({
    languages = {
        c = { compiler = "cg121", options = {} },
        cpp = { compiler = "g121", options = {} },
        rust = { compiler = "r1600", options = {} },
        -- any_additional_filetype = { compiler = ..., options = ... },
    },
    quickfix = {
        enable = false, -- whether to populate the quickfix list in case of errors
        auto_open = false -- whether to open the quickfix list in case of errors
    },
    url = "https://godbolt.org" -- can be changed to a different godbolt instance
})
