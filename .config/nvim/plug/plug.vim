"
"           ██                            ██                
"          ░░                    ██████  ░██          █████ 
"  ██    ██ ██ ██████████       ░██░░░██ ░██ ██   ██ ██░░░██
" ░██   ░██░██░░██░░██░░██ █████░██  ░██ ░██░██  ░██░██  ░██
" ░░██ ░██ ░██ ░██ ░██ ░██░░░░░ ░██████  ░██░██  ░██░░██████
"  ░░████  ░██ ░██ ░██ ░██      ░██░░░   ░██░██  ░██ ░░░░░██
"   ░░██   ░██ ███ ░██ ░██      ░██      ███░░██████  █████ 
"    ░░    ░░ ░░░  ░░  ░░       ░░      ░░░  ░░░░░░  ░░░░░  
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
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

Plug 'mhinz/vim-startify'
Plug 'wsdjeg/FlyGrep.vim'

" Git"
" Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'
Plug 'sodapopcan/vim-twiggy'

" Editor
Plug 'machakann/vim-sandwich'
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
Plug 'jlanzarotta/bufexplorer', {'on': 'BufExplorer'}
Plug 'Shougo/vimproc.vim', { 'build': 'make' }
Plug 'terryma/vim-multiple-cursors'
Plug 'Chiel92/vim-autoformat'
" From another .vimrc
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-misc'

" Git
Plug 'airblade/vim-gitgutter'
"Plug 'mhinz/vim-signify'
" Indent
Plug 'Yggdroot/indentLine'

"------------------------------------------------------------
" Autocomplete and syntax
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/denite.nvim'
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'othree/csscomplete.vim', { 'for': 'css' }
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
" Plug 'scrooloose/nerdtree'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'on': 'Files' }
" Go
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', {'build': 'make', 'for': 'go'}

Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
Plug 'zchee/deoplete-jedi', { 'for' : 'python' }
Plug 'neomake/neomake'
" Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'

Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'christoomey/vim-tmux-navigator'
" All of your Plugins must be added before the following line
call plug#end()            " required
"}}}
