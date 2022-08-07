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

-- Open a "left-hand explore window". remap to Telescope.nvim eventually
keymap("n", "<leader>e", ":Lex 30<cr>", options)

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

-- Convenient exit if unless unsaved changes
keymap("n", "<leader>q", ":qa<CR>", options)

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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal_options)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal_options)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal_options)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal_options)
