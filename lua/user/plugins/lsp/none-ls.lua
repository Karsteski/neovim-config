-- Literally only the repo name changed for this plugin, the API remains the same
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.markdownlint,

		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.diagnostics.markdownlint.with({
		    extra_args = { "--disable MD013" }, -- Disable line_length checking
		}),
	},
})
