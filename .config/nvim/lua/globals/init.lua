CONFIG_PATH = os.getenv("HOME") .. "/.config/nvim"
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")
TERMINAL = vim.fn.expand("$TERMINAL")
USER = vim.fn.expand("$USER")

O = {
	keys = { leader_key = "space" },
	colorscheme = "nord",
	line_wrap_cursor_movement = true,
	transparent_window = false,
	format_on_save = true,
	lint_on_save = true,
	vsnip_dir = os.getenv("HOME") .. "/.config/snippets",

	treesitter = {
		ensure_installed = {
			"bash",
			"css",
			"dockerfile",
			"html",
			"go",
			"lua",
			"java",
			"javascript",
			"json",
			"php",
			"python",
			"typescript",
			"vue",
			"yaml",
		},
		ignore_install = { "haskell" },
		highlight = { enabled = true },
		playground = { enabled = true },
		rainbow = { enabled = false },
	},

	default_options = {
		backup = false, -- creates a backup file
		clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 2, -- more space in the neovim command line for displaying messages
		colorcolumn = "99999", -- fixes indentline for now
		completeopt = { "menuone", "noselect" },
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based foloding
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		guifont = "monospace:h17", -- the font used in graphical neovim applications
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		smartindent = true, -- make indenting smarter again
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- set the title of window to the value of the titlestring
		-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
		undodir = CACHE_PATH .. "/undo", -- set an undo directory
		undofile = true, -- enable persisten undo
		updatetime = 300, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
		relativenumber = false, -- set relative numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		spell = false,
		spelllang = "en",
		scrolloff = 8, -- is one of my fav
		sidescrolloff = 8,
	},

	lsp = {
		diagnostics = {
			virtual_text = { prefix = "", spacing = 0 },
			signs = true,
			underline = true,
		},
		document_highlight = true,
		popup_border = "single",
		default_keybinds = true,
		on_attach_callback = nil,
		ensure_installed = {
			"bash",
			"css",
			"dockerfile",
			"html",
			"go",
			"lua",
			"jdtls",
			"javascript",
			"json",
			"kotlin",
			"php",
			"python",
			"typescript",
			"vue",
			"yaml",
		},
	},

	disabled_built_ins = {
		"netrw",
		"netrwPlugin",
		"netrwSettings",
		"netrwFileHandlers",
		"gzip",
		"zip",
		"zipPlugin",
		"tar",
		"tarPlugin",
		"getscript",
		"getscriptPlugin",
		"vimball",
		"vimballPlugin",
		"2html_plugin",
		"logipat",
		"rrhelper",
		"spellfile_plugin",
		"matchit",
	},

	plugin = {
		lspinstall = {},
		telescope = {},
		compe = {},
		autopairs = {},
		treesitter = {},
		formatter = {},
		lint = {},
		nvimtree = {},
		gitsigns = {},
		which_key = {},
		comment = {},
		rooter = {},
		galaxyline = {},
		bufferline = {},
		dap = {},
		dashboard = {},
		terminal = {},
		zen = {},
	},

	-- TODO: refactor for tree
	auto_close_tree = 0,
	nvim_tree_disable_netrw = 0,

	database = { save_location = "~/.config/lunarvim_db", auto_execute = 1 },

	-- TODO: just using mappings (leader mappings)
	user_which_key = {},

	user_plugins = {
		-- use lv-config.lua for this not put here
	},

	user_autocommands = { { "FileType", "qf", "set nobuflisted" } },

	formatters = { filetype = {} },

	-- TODO move all of this into lang specific files, only require when using
	lang = {
		efm = {},
		emmet = { active = false },
		svelte = {},
		tailwindcss = {
			active = false,
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
		},
		tsserver = {
			-- @usage can be 'eslint' or 'eslint_d'
			linter = "",
			diagnostics = {
				virtual_text = { spacing = 0, prefix = "" },
				signs = true,
				underline = true,
			},
			formatter = { exe = "prettier", args = {} },
		},
	},
}

require("lang.clang").config()
require("lang.clojure").config()
require("lang.cmake").config()
require("lang.cs").config()
require("lang.css").config()
require("lang.dart").config()
require("lang.dockerfile").config()
require("lang.elixir").config()
require("lang.elm").config()
require("lang.go").config()
require("lang.graphql").config()
require("lang.html").config()
require("lang.java").config()
require("lang.json").config()
require("lang.julia").config()
require("lang.kotlin").config()
require("lang.lua").config()
require("lang.php").config()
require("lang.python").config()
require("lang.r").config()
require("lang.ruby").config()
require("lang.rust").config()
require("lang.sh").config()
require("lang.scala").config()
require("lang.svelte").config()
require("lang.swift").config()
require("lang.terraform").config()
require("lang.tex").config()
require("lang.vim").config()
require("lang.vue").config()
require("lang.yaml").config()
require("lang.zig").config()
require("lang.zsh").config()
