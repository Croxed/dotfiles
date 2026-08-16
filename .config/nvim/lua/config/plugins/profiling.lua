local gh = require('config.utils').gh

-- Interactive startup profiler. It launches child Neovim processes with
-- `--startuptime` and presents the aggregated result in a readable buffer.
vim.pack.add { gh 'dstein64/vim-startuptime' }

vim.keymap.set('n', '<leader>us', '<Cmd>StartupTime<CR>', {
  desc = 'Profile Neovim startup',
  silent = true,
})

vim.api.nvim_create_user_command('NvimVersion', function()
  local version = vim.version()
  local text = ('Neovim %d.%d.%d%s\n%s'):format(
    version.major,
    version.minor,
    version.patch,
    version.prerelease and '-dev' or '',
    vim.v.progpath
  )
  vim.notify(text, vim.log.levels.INFO, { title = 'Neovim version' })
end, { desc = 'Show the Neovim version and executable path' })

vim.keymap.set('n', '<leader>uv', '<Cmd>NvimVersion<CR>', {
  desc = 'Show Neovim version',
  silent = true,
})
