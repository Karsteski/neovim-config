-- For global variable ON_ATTACH
require('user.keymaps')

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

local lsp_defaults = {
    flags = {
        debounce_text_changes = 150
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = ON_ATTACH
}

-- Extend lspconfig's global config
local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

lspconfig['sumneko_lua'].setup({
    single_file_support = true,
    -- Must call the on_attach in default_config as these options override the global config
    on_attach = lsp_defaults.on_attach,
    settings = {
    lsp_defaults,
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

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}


cmp.setup({
    sources = {
        { name = 'nvim_lsp' }
    },
    window = {
        documentation = {
            cmp.config.window.bordered(),
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<leader>v'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({select = true})

    }),
    formatting = {
        fields = {'menu', 'abbr', 'kind'}
    },
    experimental ={
        ghost_text = false,
        native_menu = false
    }
})

require'lspconfig'.clangd.setup({
    settings = {
        lsp_defaults
    }
})


