local options = { noremap = true, silent = true }

local terminal_options = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--------------------------- Normal ----------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)
keymap("n", "<C-l>", "<C-w>l", options)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", options)
keymap("n", "<C-Down>", ":resize -2<CR>", options)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", options)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", options)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", options)
keymap("n", "<S-h>", ":bprevious<CR>", options)

-- Convenient save
keymap("n", "<C-s>", ":w<CR>", options)

-- Convenient exit
keymap("n", "<leader><S-q>", ":q<CR>", options)

-- Close buffer
keymap("n", "<leader>q", ":bd<CR>", options)

--------------------------- Insert ----------------------------
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", options)

--------------------------- Visual ----------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", options)
keymap("v", "<A-k>", ":m .-2<CR>==", options)

-- Hold onto the current "paste" text within the clipboard
keymap("v", "p", '"_dP', options) 

--------------------------- Visual Block ----------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", options)
keymap("x", "K", ":move '<-2<CR>gv-gv", options)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", options)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", options)


-- Terminal --------------------------------------
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal_options)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal_options)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal_options)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal_options)


-- LspConfig -------------------------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>v', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>y',vim.lsp.buf.formatting, opts)


-- Completion and diagnostic keybindings
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

-- Auxillary function
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

COMPLETION_MAPPINGS = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {
            "i",
            "s"
        }),
    })




-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current 
ON_ATTACH = function(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --
    local bufmap = function(mode, lhs, rhs)
      local lsp_opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, lsp_opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', vim.lsp.buf.hover)

    -- Jump to the definition
    bufmap('n', 'gd', vim.lsp.buf.definition)

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
end

-- Toggleterm ----------------------------------------------
keymap('n', '<leader>t', ':ToggleTerm direction=float<CR>', terminal_options)
keymap('t', '<leader>t', [[<C-\><C-n> :ToggleTerm<CR>]], terminal_options)
keymap('n', '<leader>g', [[:2TermExec cmd="lazygit" direction=float <CR>]], terminal_options)

-- Nvim-tree ------------------------------------------------
keymap("n", "<leader>e", ":NvimTreeToggle <CR>", options)
keymap("n", "<leader><S-e>", ":NvimTreeFindFile <CR>", options)

-- Nvim-tree default mappings
NVIM_TREE_MAPPINGS = { -- BEGIN_DEFAULT_MAPPINGS
    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
    { key = "<C-e>",                          action = "edit_in_place" },
    { key = "O",                              action = "edit_no_picker" },
    { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
    { key = "<C-v>",                          action = "vsplit" },
    { key = "<C-x>",                          action = "split" },
    { key = "<C-t>",                          action = "tabnew" },
    { key = "<",                              action = "prev_sibling" },
    { key = ">",                              action = "next_sibling" },
    { key = "P",                              action = "parent_node" },
    { key = "<BS>",                           action = "close_node" },
    { key = "<Tab>",                          action = "preview" },
    { key = "K",                              action = "first_sibling" },
    { key = "J",                              action = "last_sibling" },
    { key = "I",                              action = "toggle_git_ignored" },
    { key = "H",                              action = "toggle_dotfiles" },
    { key = "U",                              action = "toggle_custom" },
    { key = "R",                              action = "refresh" },
    { key = "a",                              action = "create" },
    { key = "d",                              action = "remove" },
    { key = "D",                              action = "trash" },
    { key = "r",                              action = "rename" },
    { key = "<C-r>",                          action = "full_rename" },
    { key = "x",                              action = "cut" },
    { key = "c",                              action = "copy" },
    { key = "p",                              action = "paste" },
    { key = "y",                              action = "copy_name" },
    { key = "Y",                              action = "copy_path" },
    { key = "gy",                             action = "copy_absolute_path" },
    { key = "[e",                             action = "prev_diag_item" },
    { key = "[c",                             action = "prev_git_item" },
    { key = "]e",                             action = "next_diag_item" },
    { key = "]c",                             action = "next_git_item" },
    { key = "-",                              action = "dir_up" },
    { key = "s",                              action = "system_open" },
    { key = "f",                              action = "live_filter" },
    { key = "F",                              action = "clear_live_filter" },
    { key = "q",                              action = "close" },
    { key = "W",                              action = "collapse_all" },
    { key = "E",                              action = "expand_all" },
    { key = "S",                              action = "search_node" },
    { key = ".",                              action = "run_file_command" },
    { key = "<C-k>",                          action = "toggle_file_info" },
    { key = "g?",                             action = "toggle_help" },
    { key = "m",                              action = "toggle_mark" },
    { key = "bmv",                            action = "bulk_move" },
} -- END_DEFAULT_MAPPINGS


-- Telescope.nvim mappings ---------------------------------------------
-- Checkout the following link for the default Telescope mappings 
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
keymap("n", "ff", ":Telescope find_files <CR>", options)
keymap("n", "fg", ":Telescope live_grep <CR>", options)
keymap("n", "fb", ":Telescope buffers <CR>", options)
keymap("n", "fh", ":Telescope help_tags <CR>", options)

-- Use nvim-notify to search the notification history
local function telescope_notify()
    require('telescope').extensions.notify.notify()
end
vim.keymap.set("n", "fn", telescope_notify, options)

-- Gitsigns.nvim
keymap("n", "bl", ":Gitsigns blame_line <CR>", options)

-- Projects.nvim: Telescope Integration keymap

keymap("n", "fp", ":Telescope projects <CR>", options)
