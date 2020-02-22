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

if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

if has('nvim-0.4')
    Plug 'liuchengxu/vim-clap'
endif

Plug 'dstein64/vim-startuptime'

" Git"
Plug 'itchyny/vim-gitbranch'

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
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'gcmt/taboo.vim'
Plug 'jlanzarotta/bufexplorer', {'on': 'BufExplorer'}
Plug 'terryma/vim-multiple-cursors'
Plug 'Chiel92/vim-autoformat'
" From another .vimrc
Plug 'junegunn/vim-easy-align'

" Git
Plug 'mhinz/vim-signify'
" Indent
Plug 'Yggdroot/indentLine'

"------------------------------------------------------------
" Autocomplete and syntax
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'liuchengxu/vista.vim'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim', { 'on': 'Files' }

Plug 'neomake/neomake'

" Fold faster, work harder
Plug 'Konfekt/FastFold'

Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
" Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
" All of your Plugins must be added before the following line
call plug#end()            " required
"}}}
