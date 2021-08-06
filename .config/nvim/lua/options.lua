require('globals')

local opt = vim.opt
local g = vim.g

-- Turn these off at startup, will be enabled later just before loading the theme
vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

--don't write to the ShaDa file on startup
vim.opt.shadafile = "NONE"

--fish slows things down
vim.opt.shell = "/bin/bash"

opt.ruler = false
opt.cul = true
opt.signcolumn = "yes"
opt.updatetime = 250 -- update interval for gitsigns
opt.lazyredraw = true

for key, val in pairs(O.default_options) do
	opt[key] = val
end

-- shortmess options
opt.shortmess:append("asI") --disable intro

-- disable tilde on end of buffer:
vim.cmd("let &fcs='eob: '")

for _, plugin in pairs(O.disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

vim.o.guifont = "FiraCode Nerd Font:h15"

require("config")
