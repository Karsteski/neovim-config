local status_ok, none_ls = pcall(require, "none-ls")
if not status_ok then
	return
end

none_ls.setup({
	sources = {
		none_ls.builtins.formatting.stylua,
		none_ls.builtins.formatting.prettierd,
		none_ls.builtins.formatting.markdownlint,
		none_ls.builtins.formatting.black,

		none_ls.builtins.diagnostics.eslint_d,
		none_ls.builtins.diagnostics.pylint,

		none_ls.builtins.diagnostics.markdownlint.with({
			extra_args = { "--disable MD013" }, -- Disable line_length checking
		}),
	},
})
