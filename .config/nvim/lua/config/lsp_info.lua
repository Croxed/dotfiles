local M = {}

local state = { buf = nil, win = nil, source_buf = nil }

local function client_lines(client)
  local config = client.config or {}
  local command = type(config.cmd) == 'table' and table.concat(config.cmd, ' ') or tostring(config.cmd or 'unknown')
  local filetypes = type(config.filetypes) == 'table' and table.concat(config.filetypes, ', ') or 'any'

  return {
    ('  %s (id: %d)'):format(client.name, client.id),
    ('    root: %s'):format(config.root_dir or 'not set'),
    ('    cmd: %s'):format(command),
    ('    filetypes: %s'):format(filetypes),
  }
end

local function render()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then return end

  local source_buf = state.source_buf
  local attached = vim.lsp.get_clients { bufnr = source_buf }
  local attached_ids = {}
  for _, client in ipairs(attached) do
    attached_ids[client.id] = true
  end

  local others = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    if not attached_ids[client.id] then others[#others + 1] = client end
  end

  local lines = {
    'LSP information',
    ('Buffer: %s'):format(vim.api.nvim_buf_get_name(source_buf) ~= '' and vim.api.nvim_buf_get_name(source_buf) or '[No Name]'),
    '',
    ('Attached clients (%d)'):format(#attached),
  }

  if #attached == 0 then lines[#lines + 1] = '  None' end
  for _, client in ipairs(attached) do
    vim.list_extend(lines, client_lines(client))
  end

  lines[#lines + 1] = ''
  lines[#lines + 1] = ('Other active clients (%d)'):format(#others)
  if #others == 0 then lines[#lines + 1] = '  None' end
  for _, client in ipairs(others) do
    vim.list_extend(lines, client_lines(client))
  end

  vim.list_extend(lines, { '', 'r refresh   q close   :checkhealth vim.lsp for diagnostics' })

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    local width = math.min(math.max(60, vim.iter(lines):fold(0, function(max, line) return math.max(max, vim.fn.strdisplaywidth(line)) end) + 2), math.floor(vim.o.columns * 0.9))
    local height = math.min(#lines, math.floor(vim.o.lines * 0.8))
    vim.api.nvim_win_set_config(state.win, {
      relative = 'editor',
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
    })
  end
end

function M.open()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    return
  end

  state.source_buf = vim.api.nvim_get_current_buf()
  state.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[state.buf].buftype = 'nofile'
  vim.bo[state.buf].bufhidden = 'wipe'
  vim.bo[state.buf].filetype = 'lspinfo'

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = 'editor',
    width = 60,
    height = 10,
    row = math.floor((vim.o.lines - 10) / 2),
    col = math.floor((vim.o.columns - 60) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' LSP Info ',
    title_pos = 'center',
  })

  vim.wo[state.win].cursorline = true
  vim.keymap.set('n', 'q', '<Cmd>close<CR>', { buffer = state.buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<Cmd>close<CR>', { buffer = state.buf, silent = true })
  vim.keymap.set('n', 'r', render, { buffer = state.buf, silent = true, desc = 'Refresh LSP information' })
  render()
end

vim.api.nvim_create_user_command('LspInfo', M.open, {
  desc = 'Show active and attached LSP clients',
  force = true,
})

vim.keymap.set('n', '<leader>li', M.open, { desc = 'LSP information' })

return M
