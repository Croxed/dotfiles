-- Installing packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
execute(
	'!git clone https://github.com/wbthomason/packer.nvim '..install_path
)
end

vim.cmd [[ packadd packer.nvim ]]
require('packer').startup(function()
	-- Package manager itself
	use {'wbthomason/packer.nvim', opt = true}
	-- Lua mappings helper
	use 'svermeulen/vimpeccable'
	-- Lua plugins writing helper
	use 'bfredl/nvim-luadev'
	-- Nord colorscheme
	use { 'arcticicestudio/nord-vim', branch = 'develop' }
	-- Custom syntaxes
    use 'sheerun/vim-polyglot'
	-- Linters integration
	use 'neomake/neomake'
	-- Status line
	use {
        'hoob3rt/lualine.nvim',
        requires = {
            {'kyazdani42/nvim-web-devicons'}
        }
    }
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
	-- Terminal helper
	use 'kassio/neoterm'
	-- Sign column
	use 'f-person/git-blame.nvim'
	use 'lewis6991/gitsigns.nvim'
	-- Git helper
	use 'tpope/vim-fugitive'
	-- Delimit stuff
	use 'Raimondi/delimitMate'
    use {
        'mg979/vim-visual-multi', branch = 'master'
    }
	-- Start page (do not use in notepad mode)
	if not vim.g.notepad_mode then
		use 'mhinz/vim-startify'
    end
    -- File browser
    use {'ms-jpq/chadtree', branch = 'chad', run='python3 -m chadtree deps'}
	-- Calculate startup time
	use 'tweekmonster/startuptime.vim'
	-- Internal NeoVim LSP configuration helper
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
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