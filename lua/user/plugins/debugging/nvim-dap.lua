local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

require("telescope").load_extension("dap")
require("persistent-breakpoints").setup({}) -- use default config

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		command = "codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

-- Common configuration to launch debug adapter
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "LspDiagnosticsSignHint", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "LspDiagnosticsSignInformation",
	linehl = "DiagnosticUnderlineInfo",
	numhl = "LspDiagnosticsSignInformation",
})
