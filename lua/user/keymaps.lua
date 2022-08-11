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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f',vim.lsp.buf.formatting, bufopts)
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
