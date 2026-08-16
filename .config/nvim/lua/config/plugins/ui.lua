local gh = require('config.utils').gh

-- [[ Installing and Configuring Plugins ]]
--
-- To install a plugin simply call `vim.pack.add` with its git url.
-- This will download the default branch of the plugin, which will usually be `main` or `master`
-- You can also have more advanced specs, which we will talk about later.
--
-- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
--
-- For example, lets say we want to install `guess-indent.nvim` - a plugin for
-- automatically detecting and setting the indentation.
--
-- We first install it from https://github.com/NMAC427/guess-indent.nvim
-- and then call its `setup()` function to start it with default settings.
-- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
--
-- See `:help gitsigns` to understand what each configuration key does.
-- Adds git related signs to the gutter, as well as utilities for managing changes
-- [[ Colorscheme ]]
-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command under that to load whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
vim.pack.add { { name = 'catppuccin', src = gh 'catppuccin/nvim' } }
---@diagnostic disable-next-line: missing-fields
require('catppuccin').setup {
  flavour = 'macchiato',
}

-- Load the colorscheme here.
vim.cmd.colorscheme 'catppuccin-macchiato'

-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
statusline.setup {
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode { trunc_width = 100 }
      local git = statusline.section_git { trunc_width = 45 }
      local diff = statusline.section_diff { trunc_width = 75 }
      local diagnostics = statusline.section_diagnostics {
        trunc_width = 75,
        signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = '󰌵 ' },
      }
      local lsp = statusline.section_lsp { trunc_width = 90 }
      local filename = statusline.section_filename { trunc_width = 140 }
      local fileinfo = statusline.section_fileinfo { trunc_width = 100 }
      local search = statusline.section_searchcount { trunc_width = 75 }
      local location = '%2l:%-2v  %P'

      return statusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      }
    end,
  },
}

-- Show a lightweight dashboard when Neovim starts without a file.
if vim.fn.argc() == 0 then
  local starter = require 'mini.starter'
  starter.setup {
    header = 'KICKSTART.NVIM',
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(8, false),
    },
    footer = 'Ready to code',
  }
end

-- Editing helpers can initialize after the first frame without affecting
-- their behavior. This keeps the theme, statusline, and dashboard immediate.
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.pack.add {
        gh 'NMAC427/guess-indent.nvim',
        gh 'lewis6991/gitsigns.nvim',
        gh 'folke/which-key.nvim',
        gh 'folke/todo-comments.nvim',
      }

      require('guess-indent').setup {}
      require('gitsigns').setup {
        signs = {
          add = { text = '+' }, ---@diagnostic disable-line: missing-fields
          change = { text = '~' }, ---@diagnostic disable-line: missing-fields
          delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
          topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
          changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
        },
      }
      require('which-key').setup {
        delay = 0,
        icons = { mappings = vim.g.have_nerd_font },
        spec = {
          { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
          { 'gr', group = 'LSP Actions', mode = { 'n' } },
        },
      }
      require('todo-comments').setup { signs = false }
      require('mini.ai').setup {
        mappings = { around_next = 'aa', inside_next = 'ii' },
        n_lines = 500,
      }
      require('mini.surround').setup()
    end)
  end,
})

-- ... and there is more!
--  Check out: https://github.com/nvim-mini/mini.nvim
