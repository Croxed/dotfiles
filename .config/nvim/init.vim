"
"              ██
"             ░░
"     ██    ██ ██ ██████████  ██████  █████
"    ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"    ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ██ ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
" ░██  ░░██   ░██ ███ ░██ ░██░███   ░░█████
"░░    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Fix shell when fish
set encoding=utf-8
set shell=fish

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-install vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent ! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  {{{
if &compatible
    set nocompatible
endif

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'tpope/vim-fugitive'
" Editor
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'

if exists('g:gui_oni')
else
    Plug 'itchyny/lightline.vim'
endif
Plug 'bling/vim-bufferline'
Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
Plug 'gcmt/taboo.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'Shougo/vimproc.vim', { 'build': 'make' }
Plug 'terryma/vim-multiple-cursors'
Plug 'Chiel92/vim-autoformat'
" From another .vimrc
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-misc'

" Git
Plug 'mhinz/vim-signify'
" Indent
Plug 'Yggdroot/indentLine'

"------------------------------------------------------------
" Autocomplete and syntax
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/denite.nvim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'othree/csscomplete.vim', { 'on_ft': 'css' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
" Plug 'scrooloose/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Go
Plug 'fatih/vim-go', { 'on_ft': 'go' }
Plug 'zchee/deoplete-go', {'build': 'make'}

Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
" Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'

Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'christoomey/vim-tmux-navigator'
" All of your Plugins must be added before the following line
call plug#end()            " required
"}}}

filetype plugin indent on
syntax enable
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" misc {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=1
" }}}

" lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive' ], [ 'filename' ], [ 'bufferline' ] ],
            \   'right': [ [ 'percent', 'lineinfo' ], [ 'filetype' ], [ 'capslock', 'fileformat', 'fileencoding' ] ]
            \ },
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v'
            \ },
            \ 'component_type': {
            \   'capslock': 'warning'
            \ },
            \ 'component_function': {
            \   'readonly': 'LightLineReadonly',
            \   'fugitive': 'LightLineFugitive',
            \   'mode': 'LightLineMode',
            \   'bufferline': 'MyBufferline',
            \   'filename': 'LightLineFilename',
            \   'fileformat': 'LightLineFileformat',
            \   'filetype': 'LightLineFiletype',
            \   'fileencoding': 'LightLineFileencoding',
            \   'capslock': 'LightLineCapslock',
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ 'tabline': {
            \   'left': [ [ 'tabs' ] ],
            \   'right': [ [ '' ] ]
            \ },
            \ 'tabline_separator': { 'left': '', 'right': '' },
            \ 'tabline_subseparator': { 'left': '|', 'right': '|' },
            \ }

let s:except_ft = 'help\|qf\|undotree\|fzf\|vim-plug\|vaffle'
function! LightLineReadonly()
    return &ft !~? s:except_ft && &readonly ? '' : ''
endfunction

function! LightLineModified()
    return &ft =~ s:except_ft ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFugitive()
    if winwidth(0) > 90 && &ft !~? s:except_ft && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! LightLineMode()
    return &ft == 'help' ? 'help' :
                \ &ft == 'undotree' ? 'undotree' :
                \ &ft == 'fzf' ? 'fzf' :
                \ &ft == 'vim-plug' ? 'plugin' :
                \ &ft == 'qf' ? 'quickfix' :
                \ &ft == 'vaffle' ? 'vaffle' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFilename()
    let fname = expand('%:f')
    return &ft =~ s:except_ft ? '' :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
    return winwidth(0) > 90 && &ft !~? s:except_ft ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 90  && &ft !~? s:except_ft ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 90  && &ft !~? s:except_ft ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineCapslock()
    if winwidth(0) > 90 && &ft !~? s:except_ft && exists("*CapsLockStatusline")
        return CapsLockStatusline()
    endif
    return ''
endfunction

function! LightLineAle()
    if winwidth(0) > 90 && &ft !~? s:except_ft && exists("*ale#statusline#Count")
        return ale#statusline#Count()
    endif
    return ''
endfunction

augroup UpdateAleLightLine
    autocmd!
    autocmd User ALELint call lightline#update()
augroup END

function! MyBufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    let alen = strlen(a)
    let blen = strlen(b)
    let clen = strlen(c)
    let w = winwidth(0) * 4 / 11
    if w < alen+blen+clen
        let whalf = (w - strlen(c)) / 2
        let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
        let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
        return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
    else
        return b . c . a
    endif
endfunction

let g:lightline.mode_map = {
            \ 'n':      'N',
            \ 'i':      'I',
            \ 'R':      'R',
            \ 'v':      'V',
            \ 'V':      'VL',
            \ 'c':      'C',
            \ "\<C-v>": 'VB',
            \ 's':      'SELECT',
            \ 'S':      'S-LINE',
            \ "\<C-s>": 'S-BLOCK',
            \ 't':      'T',
            \ '?':      '      ' }
" }}}

" deoplete.vim {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/4.0.0_1/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/4.0.0_1/lib/clang"
set omnifunc=syntaxcomplete#Complete
let g:deoplete#sources#jedi#python_path = $PYTHON3_PATH 
let g:ale_sign_column_always = 1
" deoplete.nvim recommend
set completeopt+=noselect
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"}}}

" neomake {{{
let g:neomake_open_list = 2
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 100)

" }}}

" ale.vim {{{
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
            \    'sh': ['language_server'],
            \    'python': [ 'autopep8','isort', 'yapf' ],
            \    'java': [ 'javac' ],
            \}
"}}}

" nord-vim {{{
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_comment_brightness = 18
let g:nord_cursor_line_number_background = 1

" }}}

" rust {{{
let g:rustfmt_autosave = 1
" }}}

" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" fzf {{{
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~20%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" }}}

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Sets how many lines of history VIM has to remember

set history=500

set foldmethod=marker

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w!<cr>

set shortmess+=c

" NERDTree
nmap <leader>ne :NERDTreeToggle<cr>

nmap <leader>bx :BufExplorer<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Show lines
"set list lcs=tab:\|\
set list lcs=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
" set list listchars=tab:»-,trail:·,extends:»,precedes:«

map <F7> mzgg=G`z
" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee %

" set vim startup faster
if !empty(&viminfo)
    set viminfo^=!
endif

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
set cursorline

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

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

" Set both relative number and absolute number
set number

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

set ruler
set showmode
set laststatus=2
set showcmd

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Enable syntax highlighting
syntax on

set background=dark
set termguicolors

" Colorscheme management

try
    silent! colorscheme nord 
catch
endtry
set t_Co=256
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Enable clipboard
let g:clipboard = {'copy': {'+': 'pbcopy', '*': 'pbcopy'}, 'paste': {'+': 'pbpaste', '*': 'pbpaste'}, 'name': 'pbcopy', 'cache_enabled': 0}
set clipboard+=unnamedplus
" set clipboard+=unnamedplus " fix not copying between clipboard and vim

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"}}}
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
"{{{
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

nnoremap <leader>ls :ls<CR>:b<space>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Open FZF for editing
map <leader>f :Files<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"To map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
"}}}
