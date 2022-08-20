require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.formatting.prettierd,
		require("null-ls").builtins.formatting.markdownlint,

		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.diagnostics.flake8,

		require("null-ls").builtins.diagnostics.markdownlint.with({
			extra_args = { "--disable MD013" }, -- Disable line_length checking
		}),

		require("null-ls").builtins.completion.spell,
	},
})
