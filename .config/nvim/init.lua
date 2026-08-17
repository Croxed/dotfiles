-- Core editor behavior. Leaders and options must be loaded before plugins.
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lsp_info'
require 'config.plugin_updates'

-- Native vim.pack hooks shared by the plugin modules below.
require 'config.pack'

-- Plugin groups are ordered by their startup dependencies.
require 'config.plugins.ui'
require 'config.plugins.formatting'
require 'config.plugins.treesitter'
require 'config.plugins.extras'
require 'config.plugins.profiling'

-- Heavy feature groups are initialized after the first screen is visible.
-- Completion is initialized before LSP so servers receive its enhanced
-- completion capabilities when they start.
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.schedule(function()
      require 'config.plugins.search'
      require 'config.plugins.completion'
      require 'config.plugins.lsp'
    end)
  end,
})

-- vim: ts=2 sts=2 sw=2 et
