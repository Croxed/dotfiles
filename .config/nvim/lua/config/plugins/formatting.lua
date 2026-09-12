local gh = require('config.utils').gh

-- [[ Formatting ]]
local conform
local function format()
  if not conform then
    vim.pack.add { gh 'stevearc/conform.nvim' }
    conform = require 'conform'
    conform.setup {
      notify_on_error = false,
      default_format_opts = {
        lsp_format = 'fallback',
      },
    }
  end
  conform.format { async = true }
end

vim.keymap.set({ 'n', 'v' }, '<leader>f', format, { desc = '[F]ormat buffer' })
