require('plugins/lualine')

-- Automatically install packer.nvim if it hasn't been already
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print "Installing packer.nvim. Please close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]] -- So the current Neovim instance loads packer.nvim
end

-- Reload Neovim upon saving plugins.lua for a smoother plugin experience
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so that neovim doesn't error out on the first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("There was an error (status_ok returned false)...")
    return
end

-- Use a popup window instead for style
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'                       -- Packer can manage itself

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Colour schemes
    use 'shaunsingh/solarized.nvim'






    -- Automatically set up config after cloning packer.nvim
    -- Must be at the end after all the plugins have been called
    if packer_bootstrap then
        require('packer').sync()
    end

end)



