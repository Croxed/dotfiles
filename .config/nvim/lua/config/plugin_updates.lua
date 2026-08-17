local update_dir = vim.fs.joinpath(vim.fn.stdpath 'state', 'plugin-updates')
local stamp_file = vim.fs.joinpath(update_dir, 'last-check')
local day = 24 * 60 * 60

local function read_last_check()
  if not vim.uv.fs_stat(stamp_file) then return 0 end
  local lines = vim.fn.readfile(stamp_file)
  return tonumber(lines[1]) or 0
end

local function write_last_check()
  vim.fn.mkdir(update_dir, 'p')
  vim.fn.writefile({ tostring(os.time()) }, stamp_file)
end

local function update(force)
  if not force and os.time() - read_last_check() < day then return end

  -- Record the attempt before accessing the network. An offline startup should
  -- not retry on every subsequent launch that day.
  write_last_check()
  vim.notify('Checking for plugin updates…', vim.log.levels.INFO, { title = 'vim.pack' })

  local ok, err = pcall(vim.pack.update, nil, { force = true })
  if not ok then
    vim.notify(('Plugin update failed: %s'):format(err), vim.log.levels.ERROR, { title = 'vim.pack' })
    return
  end

  vim.notify('Plugin update finished. Restart Neovim to use updated plugins.', vim.log.levels.INFO, { title = 'vim.pack' })
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    -- Keep network and Git work completely outside the startup path.
    vim.defer_fn(function() update(false) end, 2000)
  end,
})

vim.api.nvim_create_user_command('PluginUpdateNow', function() update(true) end, {
  desc = 'Update all plugins immediately',
})

vim.api.nvim_create_user_command('PluginUpdateCheck', function()
  vim.pack.update()
end, { desc = 'Review available plugin updates before applying them' })

return { update = update }
