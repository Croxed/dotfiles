local utils = require('utils.lua')

cmd [[
set encoding=utf-8
set shell=zsh
set history=500
filetype plugin indent on
set autoread
set shortmess+=aAcIws  
set expandtab smarttab shiftround autoindent smartindent smartcase
set shiftwidth=4
set tabstop=4
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

set wrap
]]

-- Incremental live completion
vim.o.inccommand = "nosplit"

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Do not save when switching buffers
vim.o.hidden = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Change preview window location
vim.g.splitbelow = true

vim.g["deoplete#enable_at_startup"] = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_status_lines = 1
vim.g.nord_uniform_diff_background = 1
vim.g.nord_cursor_line_number_background = 1

local disable_distribution_plugins = function()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end

disable_distribution_plugins()

-- MacOS clipboard
if utils.is_darwin() then
    g.clipboard = {
        name = "macOS-clipboard",
        copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
        paste = {["+"] = "pbpaste", ["*"] = "pbpaste"}
    }
elseif utils.shell_type('win32yank.exe') then
    g.clipboard = {
        name = 'win32yank',
        copy = { ['+'] = 'win32yank.exe -i --crlf', ['*'] = 'win32yank.exe -i --crlf'},
        paste = {['+'] = 'win32yank.exe -o --lf', ['*'] = 'win32yank.exe -o --lf'},
        cache_enabled = 0
    }
end

if utils.shell_type('rg') then
    vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
    vim.o.grepformat = '%f:%l:%c:%m'
elseif  utils.shell_type('ag') then
    vim.o.grepprg = 'ag --vimgrep --no-heading --smart-case'
    vim.o.grepformat = '%f:%l:%c:%m'
end