-- Automatically install lazy.nvim if it hasn't been already
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colour schemes
    {
        "edeneast/nightfox.nvim",
        lazy = false, -- Definitely load these at startup
        priority = 1000, -- Load this plugin before every other start plugin
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
    },

    {
        "akinsho/bufferline.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
    },

    -- LSP and Completion
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",

    -- Snippets!
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jxregexp"
    },
    "rafamadriz/friendly-snippets",

    -- Debugging
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },

    "nvim-telescope/telescope-dap.nvim",
    "Weissle/persistent-breakpoints.nvim",
    "theHamsta/nvim-dap-virtual-text",

    {
        "kyazdani42/nvim-tree.lua",
        -- optional, for file icons
        dependencies = "kyazdani42/nvim-web-devicons"
    },

    {
        "nvim-treesitter/nvim-treesitter",
        cmd = "TSUpdate"
    },


    {
        "nvimtools/none-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },

    -- Speed up telescope sorting performances
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = [[ cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release 
            && cmake --build build --config Release 
            && cmake --install build --prefix build ]]
    },

    {
        "akinsho/toggleterm.nvim"
    },

    "habamax/vim-godot",
    "windwp/nvim-autopairs",
    "rcarriga/nvim-notify",
    "lewis6991/gitsigns.nvim",
    "ahmedkhalf/project.nvim",
    "numToStr/Comment.nvim",
    "ethanholz/nvim-lastplace",
    "famiu/bufdelete.nvim",
    "lukas-reineke/indent-blankline.nvim",

    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig"
    },
})
