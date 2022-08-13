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



