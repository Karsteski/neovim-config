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

return require('packer').startup(function(use)
    
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
end)

