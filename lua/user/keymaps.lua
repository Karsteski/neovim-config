local options = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

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

-- Better forward and back
keymap("n", "<A-Left>", "<C-o>") -- Back
keymap("n", "<A-Right>", "<C-i>") -- Forward

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
keymap("n", "<leader>q", ":Bdelete<CR>", options)

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
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", options)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", options)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", options)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", options)

-- LspConfig -------------------------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap("n", "<leader>d", vim.diagnostic.open_float, options)
-- keymap("n", "<leader>f", vim.lsp.buf.formatting, options)
keymap("n", "[d", vim.diagnostic.goto_prev, options)
keymap("n", "]d", vim.diagnostic.goto_next, options)

-- Completion and diagnostic keybindings
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- Auxillary function
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

COMPLETION_MAPPINGS = cmp.mapping.preset.insert({
	["<C-k>"] = cmp.mapping.select_prev_item(),
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
	-- Accept currently selected item. If none selected, `select` first item.
	-- Set `select` to `false` to only confirm explicitly selected items.
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
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
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current
ON_ATTACH = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	-- Displays hover information about the symbol under the cursor
	keymap("n", "K", vim.lsp.buf.hover, options)

	-- Jump to the definition
	keymap("n", "gd", vim.lsp.buf.definition, options)

	-- Jump to declaration
	keymap("n", "gD", vim.lsp.buf.declaration, options)

	-- Lists all the implementations for the symbol under the cursor
	keymap("n", "gi", vim.lsp.buf.implementation, options)

	-- Jumps to the definition of the type symbol
	keymap("n", "go", vim.lsp.buf.type_definition, options)

	-- Lists all the references
	keymap("n", "gr", vim.lsp.buf.references, options)

	-- Displays a function's signature information
	keymap("n", "<C-k>", vim.lsp.buf.signature_help, options)

	-- Renames all references to the symbol under the cursor
	keymap("n", "<leader>rn", vim.lsp.buf.rename, options)

	-- Selects a code action available at the current cursor position
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, options)
	-- keymap("x", "<F4>", vim.lsp.buf.range_code_action, options)

	-- Move to the previous diagnostic
	keymap("n", "[d", vim.diagnostic.goto_prev, options)

	-- Move to the next diagnostic
	keymap("n", "]d", vim.diagnostic.goto_next, options)
end

-- Toggleterm ----------------------------------------------
keymap("n", "<leader>t", ":ToggleTerm direction=horizontal <CR>", options)
keymap("n", "<leader><S-t>", ":ToggleTerm direction=float <CR>", options)


keymap("t", "<leader>t", [[<C-\><C-n> :ToggleTermToggleAll <CR>]], options)
keymap("n", "<leader>g", ":Lazygit <CR>", options)

-- Nvim-tree ------------------------------------------------
keymap("n", "<leader>e", ":NvimTreeToggle <CR>", options)
keymap("n", "<leader><S-e>", ":NvimTreeFindFile <CR>", options)

-- Nvim-tree default mappings
-- stylua: ignore
NVIM_TREE_MAPPINGS_ON_ATTACH = function (bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
    return {
        desc = 'nvim-tree: ' .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
    }
    end

    -- BEGIN_DEFAULT_ON_ATTACH
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
    vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
    vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
    vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
    vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
    vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
    vim.keymap.set('n', 'bd',    api.marks.bulk.delete,                 opts('Delete Bookmarked'))
    vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
    vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle Filter: No Buffer'))
    vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
    vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Filter: Git Clean'))
    vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
    vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
    vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
    vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
    vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
    vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
    vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
    vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
    vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
    vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
    vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
    vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Filter: Git Ignore'))
    vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
    vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
    vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
    vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
    vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
    vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
    vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
    vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
    vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
    vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
    vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
    vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Filter: Hidden'))
    vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
    vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
    vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
    vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
    vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    -- END_DEFAULT_ON_ATTACH
end

-- Telescope.nvim mappings ---------------------------------------------
-- Checkout the following link for the default Telescope mappings
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
keymap("n", "ff", ":Telescope find_files <CR>", options)
keymap("n", "fg", ":Telescope live_grep <CR>", options)
keymap("n", "fb", ":Telescope buffers <CR>", options)
keymap("n", "fh", ":Telescope help_tags <CR>", options)
keymap("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<CR>", options)

vim.api.nvim_set_keymap("n", "fd", "", {
    noremap = true,
    callback = function()
        -- Use current buffer for diagnostics
        require("telescope.builtin").diagnostics({bufnr = 0})
    end
})

-- Telescope default mappings
TELESCOPE_DEFAULT_MAPPINGS = function()
	local actions = require("telescope.actions")
	local mappings = {
		i = {
			["<C-n>"] = actions.move_selection_next,
			["<C-p>"] = actions.move_selection_previous,

			["<C-c>"] = actions.close,

			["<Down>"] = actions.move_selection_next,
			["<Up>"] = actions.move_selection_previous,

			["<CR>"] = actions.select_default,
			["<C-x>"] = actions.select_horizontal,
			["<C-v>"] = actions.select_vertical,
			["<C-t>"] = actions.select_tab,

			["<C-u>"] = actions.preview_scrolling_up,
			["<C-d>"] = actions.preview_scrolling_down,

			["<PageUp>"] = actions.results_scrolling_up,
			["<PageDown>"] = actions.results_scrolling_down,

			["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			["<C-l>"] = actions.complete_tag,
			["<C-/>"] = actions.which_key,
			["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			["<C-w>"] = { "<c-s-w>", type = "command" },
		},

		n = {
			["<esc>"] = actions.close,
			["<CR>"] = actions.select_default,
			["<C-x>"] = actions.select_horizontal,
			["<C-v>"] = actions.select_vertical,
			["<C-t>"] = actions.select_tab,

			["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

			-- TODO: This would be weird if we switch the ordering.
			["j"] = actions.move_selection_next,
			["k"] = actions.move_selection_previous,
			["H"] = actions.move_to_top,
			["M"] = actions.move_to_middle,
			["L"] = actions.move_to_bottom,

			["<Down>"] = actions.move_selection_next,
			["<Up>"] = actions.move_selection_previous,
			["gg"] = actions.move_to_top,
			["G"] = actions.move_to_bottom,

			["<C-u>"] = actions.preview_scrolling_up,
			["<C-d>"] = actions.preview_scrolling_down,

			["<PageUp>"] = actions.results_scrolling_up,
			["<PageDown>"] = actions.results_scrolling_down,

			["?"] = actions.which_key,
		},
	}

    return mappings
end

-- Use nvim-notify to search the notification history
local function telescope_notify()
	require("telescope").extensions.notify.notify()
end
keymap("n", "fn", telescope_notify, options)

-- Gitsigns.nvim
keymap("n", "<leader>bl", ":Gitsigns blame_line <CR>", options)
keymap("n", "<leader>df", ":Gitsigns diffthis <CR>", options)

-- Projects.nvim: Telescope Integration keymap
keymap("n", "fp", ":Telescope projects <CR>", options)

-- Comment.nvim keybinds
COMMENT_KEYMAPS = {
	---LHS of toggle mappings in NORMAL mode
	---@type table
	toggler = {
		---Line-comment toggle keymap
		line = "gcc",
		---Block-comment toggle keymap
		block = "gbc",
	},

	---LHS of operator-pending mappings in NORMAL mode
	---LHS of mapping in VISUAL mode
	---@type table
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},

	---LHS of extra mappings
	---@type table
	extra = {
		---Add comment on the line above
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},
}

-- Markdown-preview keymaps
keymap("n", "mdp", ":MarkdownPreviewToggle <CR>", options)

-- Debugging keymaps
local dapui = require("dapui")
local dap = require("dap")

-- automatically load breakpoints when a file is loaded into the buffer.
vim.api.nvim_create_autocmd({ "BufReadPost" }, { callback = require("persistent-breakpoints.api").load_breakpoints })
local pb = require("persistent-breakpoints.api")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({"tray"})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({"tray"})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({"sidebar"})
end

keymap("n", "<leader>dbt", pb.toggle_breakpoint, options)
keymap("n", "<leader>drm", pb.clear_all_breakpoints, options)
keymap("n", "<leader>drc", dap.run_to_cursor, options)

keymap("n", "<leader>di", dapui.toggle, options)
keymap("n", "<F5>", dap.continue, options)
keymap("n", "<leader>dex", dap.terminate, options)

keymap("n", "<leader>dsc", dap.continue, options)
keymap("n", "<leader>dsu", dap.step_over, options)
keymap("n", "<leader>dsi", dap.step_into, options)
keymap("n", "<leader>dso", dap.step_out, options)

keymap("n", "<leader>dro", dap.repl.open, options)
keymap("n", "<leader>de", dapui.eval, options)

keymap("n", "<leader>dtf", ":Telescope dap frames", options) -- :)

CHAT_GPT_NVIM_MAPPINGS = {
    close = { "<C-c>" },
    submit = "<C-Enter>",
    yank_last = "<C-y>",
    yank_last_code = "<C-k>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    toggle_settings = "<C-o>",
    new_session = "<C-n>",
    cycle_windows = "<Tab>",

    -- in the Sessions pane
    select_session = "<Space>",
    rename_session = "r",
    delete_session = "d",
}

-- User Commands -------------------------------------------------------

keymap("n", "<F7>", ":MesonCompile <CR>", options)
keymap("n", "<C-F5>", ":3TermExec cmd='./oglre' dir='builddir/' <CR>", options)
