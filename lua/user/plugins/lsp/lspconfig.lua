-- In the interest of keeping keymaps in one place.
require('user.keymaps')

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,

}

local lsp_defaults = {
    flags = lsp_flags,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = ON_ATTACH
}

-- Extend lspconfig's global config
local lspconfig = require('lspconfig')

-- Need to merge lsp_defaults w/ lspconfig's global config. This is the safe way.
lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

lspconfig['clangd'].setup({
    single_file_support = true,
    on_attach = lsp_defaults.on_attach,
    settings = {
        lsp_defaults
    }
})

lspconfig['sumneko_lua'].setup({
    single_file_support = true,
    -- Must call the on_attach in default_config as these options override the global config
    on_attach = lsp_defaults.on_attach,
    flags = lsp_flags,
    settings = {
        lsp_defaults,
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
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


require('lspconfig')['pyright'].setup{
    on_attach = ON_ATTACH,
    flags = lsp_flags,
}
require('lspconfig')['clangd'].setup{
    on_attach = ON_ATTACH,
    flags = lsp_flags,
}



