cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
scopes = {o = vim.o, b = vim.bo, w = vim.wo}

if not vim.notify then
    vim.notify = print
end

if not vim.log then
    vim.log = { "levels" }
    vim.log.levels = { "Error", "Info", "Warning" }
end
function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end
function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
