-- In the interest of keeping keymaps in one place.
require('user.keymaps')

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = ON_ATTACH,
    flags = lsp_flags,
}
require('lspconfig')['clangd'].setup{
    on_attach = ON_ATTACH,
    flags = lsp_flags,
}

require'lspconfig'.sumneko_lua.setup({
  settings = {
      on_attach = ON_ATTACH,
      flags = lsp_flags,
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
