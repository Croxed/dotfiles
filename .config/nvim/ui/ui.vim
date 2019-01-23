
"          ██
"         ░░ 
"  ██   ██ ██
" ░██  ░██░██
" ░██  ░██░██
" ░██  ░██░██
" ░░██████░██
"  ░░░░░░ ░░ 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" enable mouse
set mouse=a
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif

" enable vim modelines
set modeline

"Always show current position
set ruler

" Show row number
set number

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" allows for folding on marker
set foldmethod=marker

" Set visual representation for tabs, tailing whitespace and other special characters
set list lcs=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×

" Show lines
set linebreak breakindent

" indent guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=1

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Enable syntax highlighting
syntax on

set background=dark
if (has("termguicolors"))
    set termguicolors
endif

" Colorscheme management
try
    silent! colorscheme nord 
catch
endtry
set t_Co=256

" Use Unix as the standard file type
set ffs=unix,dos,mac

"}}}