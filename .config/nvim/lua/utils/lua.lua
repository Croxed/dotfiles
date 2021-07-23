cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
g = vim.g -- a table to access global variables
scopes = {o = vim.o, b = vim.bo, w = vim.wo}

if not vim.notify then vim.notify = print end

if not vim.log then
    vim.log = {"levels"}
    vim.log.levels = {"Error", "Info", "Warning"}
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

local M = {}

function M.has_neovim_v05()
    if fn.has('nvim-0.5') == 1 then return true end
    return false
end

function M.is_root()
    local output = vim.fn.systemlist "id -u"
    return ((output[1] or "") == "0")
end

function M.is_darwin()
    local os_name = vim.loop.os_uname().sysname
    return os_name == 'Darwin'
    --[[ local output = vim.fn.systemlist "uname -s"
  return not not string.find(output[1] or "", "Darwin") ]]
end

function M.shell_type(file)
    vim.fn.system(string.format("type '%s'", file))
    if vim.v.shell_error ~= 0 then
        return false
    else
        return true
    end
end

return M