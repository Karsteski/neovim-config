-- In the interest of keeping keymaps in one place.
require("user.keymaps")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }}}}})
