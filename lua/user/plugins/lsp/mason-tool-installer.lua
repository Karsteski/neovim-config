local status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_ok then
	return
end

mason_tool_installer.setup({
	ensure_installed = {
		-- Language servers
		"lua-language-server",
        "html-lsp",
        "css-lsp",
		"clangd",
		"pyright",
		"bash-language-server",
		"cmake-language-server",
		"typescript-language-server",
		"marksman",
        "glsl_analyzer",
        "mesonlsp",

		-- Formatters
		"stylua",
		"black",
		"clang-format",
		"prettierd",

		-- Linters
		"eslint_d",
        "pylint",
        "markdownlint",

		-- Debuggers
		"codelldb",
	},
})
