
"                                                     ██
"   █████                                            ░██
"  ██░░░██  █████  ███████   █████  ██████  ██████   ░██
" ░██  ░██ ██░░░██░░██░░░██ ██░░░██░░██░░█ ░░░░░░██  ░██
" ░░██████░███████ ░██  ░██░███████ ░██ ░   ███████  ░██
"  ░░░░░██░██░░░░  ░██  ░██░██░░░░  ░██    ██░░░░██  ░██
"   █████ ░░██████ ███  ░██░░██████░███   ░░████████ ███
"  ░░░░░   ░░░░░░ ░░░   ░░  ░░░░░░ ░░░     ░░░░░░░░ ░░░ 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Fix shell when fish
set encoding=utf-8
set shell=zsh

" Sets how many lines of history VIM has to remember
set history=500

" speedup sourcing of python
" let g:loaded_python_provider = 1
let g:python_host_skip_check=1
" let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_skip_check=1
" let g:python3_host_prog = '/usr/bin/python3'

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" Hide or shorten certain messages
set shortmess+=aAcIws  

" Enable clipboard
if has('mac')
	let g:clipboard = {
		\   'name': 'macOS-clipboard',
		\   'copy': {
		\      '+': 'pbcopy',
		\      '*': 'pbcopy',
		\    },
		\   'paste': {
		\      '+': 'pbpaste',
		\      '*': 'pbpaste',
		\   },
		\   'cache_enabled': 0,
		\ }
endif

if has('clipboard')
	set clipboard& clipboard+=unnamedplus
endif

" Better grepping in vim
if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
elseif executable('ag')
	set grepformat=%f:%l:%m
	let &grepprg = 'ag --vimgrep' . (&smartcase ? ' --smart-case' : '')
endif

" set vim startup faster
if !empty(&viminfo)
    set viminfo^=!
endif

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" deoplete.nvim recommend
set completeopt+=noselect
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
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
