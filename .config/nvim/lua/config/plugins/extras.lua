-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
-- init.lua. If you want these files, they are in the repository, so you can just download them and
-- place them in the correct locations.

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the Kickstart repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--
-- require 'kickstart.plugins.debug'
-- require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

-- These features do not affect the first frame, so initialize them afterwards.
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.schedule(function()
      require 'kickstart.plugins.indent_line'
      require 'kickstart.plugins.lint'
    end)
  end,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    require 'kickstart.plugins.autopairs'
  end,
})

-- Load the explorer only when it is requested.
vim.keymap.set('n', '<leader>d', function()
  require 'kickstart.plugins.neo-tree'
  vim.cmd 'Neotree toggle'
end, { desc = 'Toggle file explorer', silent = true })

-- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--
--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
-- require 'custom.plugins'
