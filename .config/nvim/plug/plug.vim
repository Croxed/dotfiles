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

"Plug 'dstein64/vim-startuptime'
Plug 'tweekmonster/startuptime.vim'
" telescope.vim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

Plug 'glepnir/lspsaga.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'alexaandru/nvim-lspupdate'

Plug 'Raimondi/delimitMate'
Plug 'b3nj5m1n/kommentary'

Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

Plug 'hoob3rt/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
" Git"
Plug 'f-person/git-blame.nvim'
"Plug 'itchyny/vim-gitbranch'

" Editor
Plug 'machakann/vim-sandwich'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-commentary'
Plug 'bling/vim-bufferline'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'gcmt/taboo.vim'
"Plug 'terryma/vim-multiple-cursors'
" From another .vimrc
Plug 'junegunn/vim-easy-align'

" Git
Plug 'lewis6991/gitsigns.nvim'
" Indent
Plug 'Yggdroot/indentLine'

"------------------------------------------------------------
" Autocomplete and syntax
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/neco-vim'
"Plug 'Shougo/neoinclude.vim'
"Plug 'Shougo/neco-syntax'
Plug 'sheerun/vim-polyglot'
" Use release branch (Recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'liuchengxu/vista.vim'


Plug 'neomake/neomake'

" Fold faster, work harder
Plug 'Konfekt/FastFold'

Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
" Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
" All of your Plugins must be added before the following line
call plug#end()            " required
"}}}
