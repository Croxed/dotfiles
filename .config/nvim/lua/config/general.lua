local utils = require("utils.lua")

cmd([[
set encoding=utf-8
set shell=zsh
set history=500
filetype plugin indent on
set autoread
set shortmess+=aAcIws
set path+=**

set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

set nobackup nowb noswapfile

set lbr
set tw=500
]])

-- Incremental live completion
vim.o.inccommand = "nosplit"

-- Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.suda_smart_edit = 1

-- MacOS clipboard
if utils.is_darwin() then
	g.clipboard = {
		name = "macOS-clipboard",
		copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
		paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
	}
elseif utils.shell_type("win32yank.exe") then
	g.clipboard = {
		name = "win32yank",
		copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
		paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
		cache_enabled = 0,
	}
end

if utils.shell_type("rg") then
	vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
	vim.o.grepformat = "%f:%l:%c:%m"
elseif utils.shell_type("ag") then
	vim.o.grepprg = "ag --vimgrep --no-heading --smart-case"
	vim.o.grepformat = "%f:%l:%c:%m"
end
