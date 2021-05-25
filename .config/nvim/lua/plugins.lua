-- Installing packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute(
    '!git clone https://github.com/wbthomason/packer.nvim '..install_path
    )
end

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

vim.cmd [[ packadd packer.nvim ]]
packer = require('packer');
packer.startup(function()
    -- Package manager itself
    use {'wbthomason/packer.nvim', opt = true}
    -- Lua mappings helper
    use 'svermeulen/vimpeccable'
    -- Nord colorscheme
    use 'shaunsingh/nord.nvim'
    -- Custom syntaxes
    -- use 'sheerun/vim-polyglot'
    -- dashboard
    -- folke stuff
    use 'folke/lsp-colors.nvim'
    use "folke/lua-dev.nvim"
    -- Linters integration
    use 'neomake/neomake'
    -- Status line
    use {
        'hoob3rt/lualine.nvim',
        requires = {
            {'kyazdani42/nvim-web-devicons'}
        }
    }
    -- Tree view
    use {"kyazdani42/nvim-tree.lua"}
    -- Navigation
    use 'christoomey/vim-tmux-navigator'
    -- Typing helpers
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'b3nj5m1n/kommentary'
    -- Filetype icons
    use 'ryanoasis/vim-devicons'
    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'kyazdani42/nvim-web-devicons'}
        }
    }
    -- Sign column
    --use 'f-person/git-blame.nvim'
    -- use 'lewis6991/gitsigns.nvim'
    use 'mhinz/vim-signify'
    -- Delimit stuff
    use 'Raimondi/delimitMate'
    use {
        'mg979/vim-visual-multi', branch = 'master'
    }
    -- Start page (do not use in notepad mode)
    if not vim.g.notepad_mode then
        use 'mhinz/vim-startify'
    end
    -- Calculate startup time
    use 'tweekmonster/startuptime.vim'
    -- Internal NeoVim LSP configuration helper
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'alexaandru/nvim-lspupdate'
    -- Completion engine
    use 'hrsh7th/nvim-compe'
    use {
        'hrsh7th/vim-vsnip-integ',
        requires = {
            {'hrsh7th/vim-vsnip'}
        }
    }
    use 'honza/vim-snippets'
    use 'norcalli/nvim-colorizer.lua'
    vim.g.treesitter_enabled = true
    -- TreeSitter-based syntax highlighting & text objects
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
end)

if not file_exists(fn.expand('~/.config/nvim/plugin/packer_compiled.vim')) then
    packer.sync()
end
