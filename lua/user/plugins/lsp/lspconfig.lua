-- In the interest of keeping keymaps in one place.
require("user.keymaps")

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local lsp_defaults = {
	flags = lsp_flags,
	capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = ON_ATTACH,
}

-- Extend lspconfig's global config
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- Need to merge lsp_defaults w/ lspconfig's global config. This is the safe way.
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
	if server == "sumneko_lua" then
		lspconfig[server].setup({
			-- Must call the on_attach in default_config as these options override the global config
			on_attach = lsp_defaults.on_attach,
			flags = lsp_flags,
			settings = {
				lsp_defaults,
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	else
		lspconfig[server].setup({
			single_file_support = true,
			on_attach = lsp_defaults.on_attach,
			settings = {
				lsp_defaults,
			},
		})
	end
end
