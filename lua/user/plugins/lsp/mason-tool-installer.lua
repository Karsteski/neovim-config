require("mason-tool-installer").setup({
	ensure_installed = {
        -- Language servers
		"lua-language-server",
		"clangd",
		"pyright",
        "bash-language-server",
        "cmake-language-server",
        "typescript-language-server",
        "marksman",

        -- Formatters 
		"stylua",
        "black",
        "clang-format",
        "prettierd",

        -- Linters
        "eslint_d",
        "flake8",

        -- Debuggers
        "codelldb",
	},
})
