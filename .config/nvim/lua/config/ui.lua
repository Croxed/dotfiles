require('utils.lua')

cmd [[

set modeline

set ruler

set number

set cmdheight=2

set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase

set hlsearch

set incsearch

set lazyredraw

set magic

set showmatch

set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=1

set foldmethod=marker

set list lcs=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×

set linebreak breakindent
set so=7

set ffs=unix,dos,mac
]]

opt('o', 'termguicolors', true)
cmd 'colorscheme nord'

g.indent_guides_enable_on_vim_startup=1
g.indent_guides_auto_colors=1
