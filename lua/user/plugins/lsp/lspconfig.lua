-- In the interest of keeping keymaps in one place.
require("user.keymaps")

-- For win bar navigation contexts
require("user.plugins.nvim-navic")

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
	return
end

local on_attach_functions = function(client, bufnr)
    ON_ATTACH(client, bufnr)
    NVIM_NAVIC(client, bufnr)
end

local lsp_defaults = {
	flags = lsp_flags,
	capabilities = cmp_nvim_lsp.default_capabilities(),
	on_attach = on_attach_functions
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

-- Fix for clangd offset_encodings issue
local clangd_capabilities = vim.lsp.protocol.make_client_capabilities()
clangd_capabilities.offsetEncoding = { "utf-16" }

local function concatenateTables(table_1, table_2)
    for i = 1, #table_2 do
        table_1[#table_1 + 1] = table_2[i]
    end
    return table_1
end

-- Just add the Godot server in there...
local all_lsp_servers = concatenateTables({ "gdscript" }, mason_lspconfig.get_installed_servers())

for _, server in ipairs(all_lsp_servers) do
	if server == "lua_ls" then
		lspconfig[server].setup({
			settings = {
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
	elseif server == "clangd" then
		lspconfig[server].setup({
			capabilities = clangd_capabilities,
		})
    elseif server == "gdscript" then
        lspconfig[server].setup({
            capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
        })
	else
		lspconfig[server].setup({
			single_file_support = true,
		})
	end
end
