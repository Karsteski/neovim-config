local nvim_navic = require("nvim-navic")

nvim_navic.setup({
    highlight = true
})

NVIM_NAVIC = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        nvim_navic.attach(client, bufnr)
    end
end

