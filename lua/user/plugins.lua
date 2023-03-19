-- Automatically install packer.nvim if it hasn't been already
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer.nvim. Please close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]]) -- So the current Neovim instance loads packer.nvim
end

-- Reload Neovim upon saving plugins.lua for a smoother plugin experience
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so that neovim doesn't error out on the first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("There was an error (status_ok returned false)...")
    return
end

-- Use a popup window instead for style
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Packer can manage itself

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })

    -- LSP and Completion
    use({
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
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    })

    -- Debugging
    use({ "rcarriga/nvim-dap-ui", requires = {
        "mfussenegger/nvim-dap",
    } })
    use("nvim-telescope/telescope-dap.nvim")
    use("Weissle/persistent-breakpoints.nvim")
    use("theHamsta/nvim-dap-virtual-text")

    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
    })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.x",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- Speed up telescope sorting performances
    use({ 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    })

    use({
        "habamax/vim-godot"
    })

    use({ "akinsho/toggleterm.nvim", tag = "v2.*" })
    use({ "windwp/nvim-autopairs" })
    use({ "rcarriga/nvim-notify" })
    use({ "lewis6991/gitsigns.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "numToStr/Comment.nvim" })
    use({ "ethanholz/nvim-lastplace" })
    use({ "p00f/godbolt.nvim" }) -- Display assembly for current buffer or visual selection (Godbolt.org)
    use({ "Shatur/neovim-session-manager" })
    use({ "famiu/bufdelete.nvim" })
    use({ "lukas-reineke/indent-blankline.nvim"})

    use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" })


    -- Markdown Preview installation
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })


    -- ChatGPT.nvim -----------------------------------------------------
    use({
        "MunifTanjim/nui.nvim",
        module = {"nui.layout", "nui.popup"},
        module_pattern = {"nui.*"}
    })

    use ({
        "jackMort/ChatGPT.nvim",
        opt = true,
        keys = {"<leader>gpt"},
        module_pattern = {"chatgpt*"},
        after = {"nui.nvim", "telescope.nvim"},
        setup = function()
            require("user.plugins.chatgpt").load_api_key()
        end,
        config = function()
            require("user.plugins.chatgpt").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })


    -- Colour schemes
    use("shaunsingh/solarized.nvim")
    use("edeneast/nightfox.nvim")

    -- Automatically set up config after cloning packer.nvim
    -- Must be at the end after all the plugins have been called
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
