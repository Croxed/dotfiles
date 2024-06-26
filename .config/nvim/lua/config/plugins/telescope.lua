local M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",

  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-z.nvim" },
    -- { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}

function M.project_files(opts)
  opts = opts or {}
  opts.show_untracked = true
  if vim.loop.fs_stat(".git") then
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

function M.config()
  -- local actions = require("telescope.actions")
  local trouble = require("trouble.sources.telescope")

  local telescope = require("telescope")
  local borderless = true
  telescope.setup({
    extensions = {
      -- fzf = {
      --   fuzzy = true, -- false will only do exact matching
      --   override_generic_sorter = true, -- override the generic sorter
      --   override_file_sorter = true, -- override the file sorter
      --   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      --   -- the default case_mode is "smart_case"
      -- },
    },
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open,
          ["<C-Down>"] = require("telescope.actions").cycle_history_next,
          ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
        },
      },
      -- mappings = { i = { ["<esc>"] = actions.close } },
      -- vimgrep_arguments = {
      --   'rg',
      --   '--color=never',
      --   '--no-heading',
      --   '--with-filename',
      --   '--line-number',
      --   '--column',
      --   '--smart-case'
      -- },
      -- prompt_position = "bottom",
      prompt_prefix = " ",
      selection_caret = " ",
      -- entry_prefix = "  ",
      -- initial_mode = "insert",
      -- selection_strategy = "reset",
      -- sorting_strategy = "descending",
      -- layout_strategy = "horizontal",
      -- layout_defaults = {
      --   horizontal = {
      --     mirror = false,
      --   },
      --   vertical = {
      --     mirror = false,
      --   },
      -- },
      -- file_sorter = require"telescope.sorters".get_fzy_file
      -- file_ignore_patterns = {},
      -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      -- shorten_path = true,
      winblend = borderless and 0 or 10,
      -- width = 0.7,
      -- preview_cutoff = 120,
      -- results_height = 1,
      -- results_width = 0.8,
      -- border = false,
      -- color_devicons = true,
      -- use_less = true,
      -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
  })

  -- telescope.load_extension("frecency")
  telescope.load_extension("fzf")
  telescope.load_extension("z")
  telescope.load_extension("file_browser")
  telescope.load_extension("notify")
  pcall(telescope.load_extension, "project")
  -- Telescope
  local builtin = require('telescope.builtin')
  vim.keymap.set("n", "<Leader>gt", builtin.git_status)
  vim.keymap.set("n", "<Leader>cm", builtin.git_commits)
  vim.keymap.set("n", "<Leader>.", builtin.find_files)
  vim.keymap.set("n", "<Leader>ff", builtin.find_files)
  vim.keymap.set("n", "<Leader>bb", builtin.buffers)
  vim.keymap.set("n", "<Leader>fh", builtin.help_tags)
  vim.keymap.set("n", "<Leader>fr", builtin.oldfiles)
end

function M.init()
  vim.keymap.set("n", "<leader><space>", function()
    require("config.plugins.telescope").project_files()
  end, { desc = "Find File" })

  vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
  end, { desc = "Find Dot File" })

  vim.keymap.set("n", "<leader>pp", function()
    require("telescope").extensions.project.project({})
  end, { desc = "Find Project" })
end

return M
