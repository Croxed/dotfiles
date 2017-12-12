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
" => VimPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Fix shell when fish
set encoding=utf-8
set shell=zsh

" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent ! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'tpope/vim-fugitive'
" Editor
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'

if system('uname') =~ "Darwin"
    try
        Plug 'itchyny/lightline.vim'
    catch
    endtry
else
    try
        Plug 'itchyny/lightline.vim'
    catch
    endtry
endif

Plug 'bling/vim-bufferline'
Plug 'morhetz/gruvbox'
Plug 'Raimondi/delimitMate'
Plug 'honza/vim-snippets'
Plug 'sjl/gundo.vim'
Plug 'sjl/vitality.vim'
Plug 'gcmt/taboo.vim'
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'rizzatti/dash.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
Plug 'terryma/vim-multiple-cursors'
Plug 'ryanoasis/vim-devicons'
Plug 'Chiel92/vim-autoformat'
Plug 'jonathanfilip/vim-lucius'
Plug 'dracula/vim', { 'as': 'dracula' }
" From another .vimrc
Plug 'beloglazov/vim-online-thesaurus'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vader.vim',
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-scriptease'
Plug 'xolox/vim-misc'
Plug 'dag/vim-fish'
" Git
Plug 'airblade/vim-gitgutter'
" Indent
Plug 'nathanaelkane/vim-indent-guides'
" Vim themes
Plug 'chriskempson/base16-vim'

"------------------------------------------------------------
" Autocomplete and syntax
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-clang'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'zchee/deoplete-jedi'
"Plug 'landaire/deoplete-swift'
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-completion-manager'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'othree/csscomplete.vim'
Plug 'roxma/clang_complete'
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'


Plug 'felixhummel/setcolors.vim'
Plug 'w0rp/ale'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'dylanaraps/wal'


" All of your Plugins must be added before the following line
call plug#end()            " required
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive' ], [ 'filename' ], [ 'bufferline' ] ],
            \   'right': [ [ 'ale', 'percent', 'lineinfo' ], [ 'filetype' ], [ 'capslock', 'fileformat', 'fileencoding' ] ]
            \ },
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v'
            \ },
            \ 'component_expand': {
            \   'ale': 'LightLineAle'
            \ },
            \ 'component_type': {
            \   'ale': 'error',
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
    if winwidth(0) > 90 && &ft !~? s:except_ft && exists("*ALEGetStatusLine")
        return ALEGetStatusLine()
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
let g:deoplete#sources#jedi#python_path = "/usr/local/bin/python3"
let g:ale_sign_column_always = 1
" deoplete.nvim recommend
set completeopt+=noselect
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"}}}

" ale.vim {{{
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"}}}

" airline.vim {{{
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
"let g:Powerline_sybols = 'unicode'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1

"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'BUFFERS'
let g:airline#extensions#tabline#tabs_label = 'TABS'

let g:airline_theme = 'nord'
"}}}

" nvim-completion-manager {{{
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
if system('uname') =~ "Darwin"
    try
        let g:clang_library_path='/usr/local/Cellar/llvm/5.0.0/lib/'
    catch
    endtry
else
    try
        let g:clang_library_path='/usr/lib/clang/5.0.0/lib'
    endtry
endif
"}}}

" rust {{{
let g:rustfmt_autosave = 1
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

"Always show current position
set ruler

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
"set relativenumber

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
" Enable syntax highlighting
syntax on

set background=dark

" Colorscheme management

if system('uname') =~ "Darwin"
    try
        silent! colorscheme nord
    catch
    endtry
else
    try
        silent! colorscheme wal
    catch
    endtry
endif
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
set clipboard+=unnamedplus " fix not copying between clipboard and vim

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

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"}}}
""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
"{{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

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


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
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
