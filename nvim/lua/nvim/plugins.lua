local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim ... "
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenver you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on the first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Error with require packer") 
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {}
        end,
    },
}

-- Install plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself



    -- PLUGINS BEGIN --
        -- An implementation of the Popup API from vim in Neovim
        use "nvim-lua/popup.nvim"

        -- Useful lua functions used by lots of plugins
        use "nvim-lua/plenary.nvim"

        -- Preview markdown files
        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        })

        -- Colorschemes
        use "navarasu/onedark.nvim"

        -- cmp Plugins
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'saadparwaiz1/cmp_luasnip'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'

        -- snippets
        use 'L3MON4D3/LuaSnip'
        use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

        -- LSP
        use "neovim/nvim-lspconfig" -- enable LSP
        use "williamboman/nvim-lsp-installer" -- simple to use language server installer

        -- Commenter
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        -- Autopairs
        use "windwp/nvim-autopairs"
    -- PLUGINS END --




    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)