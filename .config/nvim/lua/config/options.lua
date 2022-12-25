require("globals")
require("config.general")

-- vim.opt.concealcursor = "nc" -- Hide * markup for bold and italic
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.g.mapleader = " "
vim.g.maplocalleader = ","
--don't write to the ShaDa file on startup
vim.opt.shadafile = "NONE"

--fish slows things down
vim.opt.shell = "/bin/bash"

vim.opt.ruler = false
vim.opt.cul = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250 -- update interval for gitsigns
vim.opt.lazyredraw = true

for key, val in pairs(O.default_options) do
	vim.opt[key] = val
end

-- shortmess options
vim.opt.shortmess:append("asI") --disable intro

-- disable tilde on end of buffer:
vim.cmd("let &fcs='eob: '")

for _, plugin in pairs(O.disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

vim.g.did_load_filetypes = 1

-- don't load the plugins below
local builtins = {
  "gzip",
  "zip",
  "zipPlugin",
  "fzf",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end

local notifs = {}
local notify = {
  orig = vim.notify,
  lazy = function(...)
    table.insert(notifs, { ... })
  end,
}
vim.notify = notify.lazy

local function lazy_notify()
  local check = vim.loop.new_check()
  local start = vim.loop.hrtime()
  check:start(function()
    if vim.notify ~= notify.lazy then
    elseif (vim.loop.hrtime() - start) / 1e6 > 300 then
      vim.notify = notify.orig
    else
      return
    end
    check:stop()
    -- use the new notify
    vim.schedule(function()
      for _, notif in ipairs(notifs) do
        vim.notify(unpack(notif))
      end
    end)
  end)
end
lazy_notify()

-- don't load the plugins below
local builtins = {
  "gzip",
  "zip",
  "zipPlugin",
  "fzf",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Use proper syntax highlighting in code blocks
local fences = {
  "lua",
  -- "vim",
  "json",
  "typescript",
  "javascript",
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
vim.g.markdown_fenced_languages = fences
vim.g.markdown_recommended_style = 0
