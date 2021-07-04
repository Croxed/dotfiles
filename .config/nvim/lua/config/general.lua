require('utils.lua')

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