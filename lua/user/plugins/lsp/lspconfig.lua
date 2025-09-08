-- In the interest of keeping keymaps in one place.
require("user.keymaps")

local on_attach = ON_ATTACH

-- Make on_attach keymaps work! :)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LSP_attach_config", { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf
        on_attach(client, bufnr)
    end
})

-- To let the LSP know that the global "vim" exists
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})
