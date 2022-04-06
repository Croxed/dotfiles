local present, _ = pcall(require, "packerInit")
local packer

if present then
	packer = require("packer")
else
	return false
end

local use = packer.use

return packer.startup(function()
	use({
		"wbthomason/packer.nvim",
	})

	use({
		"lewis6991/impatient.nvim",
	})

	use({
		"nathom/filetype.nvim",
	})

	use({
		"lambdalisue/suda.vim",
	})

	use({
		"akinsho/nvim-bufferline.lua",
		as = 'bufferline',
		requires = 'kyazdani42/nvim-web-devicons',
		event = 'BufWinEnter',
		config = function()
			require('plugins.bufferline')
		end,
	})

	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		after = "nvim-lspconfig",
	})

	use({
		"famiu/feline.nvim",
		after = "nvim-web-devicons",
		config = function()
			require("plugins.statusline")
		end,
	})

	-- color related stuff
	use({
		"shaunsingh/nord.nvim",
		after = "packer.nvim",
		config = function()
			require("theme")
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("plugins.others").colorizer()
		end,
	})

	-- language related plugins
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufWinEnter",
		run = ':TSUpdate',
		config = function()
			require("plugins.treesitter")
		end,
	})

	use({
		'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'
	})
	use({
		'windwp/nvim-ts-autotag', after = 'nvim-treesitter'
	})

	use({
		"folke/trouble.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("plugins.trouble")
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
	})

	use({
		"williamboman/nvim-lsp-installer",
	})

	use({
		"neovim/nvim-lspconfig",
		after = "nvim-lsp-installer",
		config = function()
			require("plugins.lspconfig")
		end,
	})

	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"onsails/lspkind-nvim",
		config = function()
			require("plugins.others").lspkind()
		end,
	})

	use({
		"kosayoda/nvim-lightbulb",
		after = "nvim-lspconfig",
	})

	-- load compe in insert mode only
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.cmp")
		end,
		wants = "LuaSnip",
		requires = {
			{
				"L3MON4D3/LuaSnip",
				wants = "friendly-snippets",
				event = "InsertCharPre",
				config = function()
					require("plugins.luasnip")
				end,
			},
			{
				"hrsh7th/cmp-nvim-lsp",
			},
			{
				"saadparwaiz1/cmp_luasnip",
			},
			{
				"hrsh7th/cmp-buffer",
			},
			{
				"hrsh7th/cmp-path",
			},
			{
				"ray-x/cmp-treesitter",
			},
			{
				"rafamadriz/friendly-snippets",
				event = "InsertCharPre",
			},
		},
	})

	-- file managing , picker etc
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		config = function()
			require("plugins.nvimtree")
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		after = "nord.nvim",
	})

	use({
		"nvim-lua/plenary.nvim",
	})
	use({
		"nvim-lua/popup.nvim",
		after = "plenary.nvim",
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		cmd = "Telescope",
		config = function()
			require("plugins.telescope")
		end,
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		cmd = "Telescope",
	})
	use({
		"nvim-telescope/telescope-media-files.nvim",
		cmd = "Telescope",
	})

	-- git stuff
	use({
		"lewis6991/gitsigns.nvim",
		after = "plenary.nvim",
		event = 'BufRead',
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- misc plugins
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.autopairs")
		end,
	})

	use({
		"andymass/vim-matchup",
		event = "CursorMoved",
	})

	use({
		"b3nj5m1n/kommentary",
		config = function()
			require("plugins.others").comment()
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = "require'plugins.null-ls'"
	})

	use({"b0o/schemastore.nvim", after = 'nvim-lsp-installer'})

	use({
		'alexghergh/nvim-tmux-navigation',
		config = function()
			require'nvim-tmux-navigation'.setup {
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				}
			}
		end
	})

	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.dashboard")
		end,
	})

	use({
		"tweekmonster/startuptime.vim",
		cmd = "StartupTime",
	})

	-- smooth scroll
	use({
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("plugins.others").neoscroll()
		end,
	})

	use({
		"Pocco81/TrueZen.nvim",
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			"TZFocus",
		},
		config = function()
			require("plugins.zenmode")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			require("plugins.others").blankline()
		end,
	})

	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"folke/lua-dev.nvim",
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.others").notify()
		end,
	})

  use {
    "danymat/neogen",
    config = function()
        require('neogen').setup {
            enabled = true
        }
    end,
    requires = "nvim-treesitter/nvim-treesitter"
  }

	use({
		"phaazon/hop.nvim",
		cmd = {
			"HopWord",
			"HopLine",
			"HopChar1",
			"HopChar2",
			"HopPattern",
		},
		as = "hop",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup()
		end,
	})
end)
