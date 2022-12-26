do return {
  {
    "nathom/filetype.nvim",
    event = "VeryLazy",
    config = function ()
      require('filetype').setup({})
    end
  },
  "MunifTanjim/nui.nvim",
  "windwp/nvim-spectre",
  {
    "folke/which-key.nvim",
    event = "VimEnter",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
    require("inc_rename").setup()
    end,
  },
  {
    "folke/paint.nvim",
    enabled = false,
    event = "BufReadPre",
    config = function()
    require("paint").setup({
      highlights = {
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*(@%w+)",
        hl = "Constant",
      },
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%[%[(@%w+)",
        hl = "Constant",
      },
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*@field%s+(%S+)",
        hl = "@field",
      },
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*@class%s+(%S+)",
        hl = "@variable.builtin",
      },
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*@alias%s+(%S+)",
        hl = "@keyword",
      },
      {
        filter = { filetype = "lua" },
        pattern = "%s*%-%-%-%s*@param%s+(%S+)",
        hl = "@parameter",
      },
      },
    })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function ()
      require('dressing').setup()
    end
  },
  -- LSP
  {
    "SmiteshP/nvim-navic",
    config = function()
    vim.g.navic_silence = true
      require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    init = function()
      -- prompt for a refactor to apply when the remap is triggered
      vim.keymap.set("v", "<leader>r", function()
        require("refactoring").select_refactor()
      end, { noremap = true, silent = true, expr = false })
    end,
    config = function()
      require("refactoring").setup({})
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    init = function()
    vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
    config = function()
    require("symbols-outline").setup()
    end,
  },
  {
    "danymat/neogen",
    config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
    require("hlargs").setup({
      excluded_argnames = {
      usages = {
        lua = { "self", "use" },
      },
      },
    })
    end,
  },
  -- Theme: icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
    require("nvim-web-devicons").setup({ default = true })
    end,
  },
  {
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
    require("terminal").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
    require("trouble").setup({
      auto_open = false,
      use_diagnostic_signs = true, -- en
    })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
    require("persistence").setup({
      options = { "buffers", "curdir", "tabpages", "winsize", "help" },
    })
    end,
  },
  {
    "Wansmer/treesj",
    keys = "J",
    config = function()
      require("treesj").setup({ use_default_keymaps = false })
      vim.keymap.set("n", "J", "<cmd>TSJToggle<cr>")
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    init = function()
    vim.keymap.set({ "n", "x" }, "<leader>cR", function()
      require("ssr").open()
    end, { desc = "Structural Replace" })
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  } end
