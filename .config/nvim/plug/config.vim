
"           ██                                                   ████
"  ██████  ░██          █████                                   ░██░ 
" ░██░░░██ ░██ ██   ██ ██░░░██        █████   ██████  ███████  ██████
" ░██  ░██ ░██░██  ░██░██  ░██ █████ ██░░░██ ██░░░░██░░██░░░██░░░██░ 
" ░██████  ░██░██  ░██░░██████░░░░░ ░██  ░░ ░██   ░██ ░██  ░██  ░██  
" ░██░░░   ░██░██  ░██ ░░░░░██      ░██   ██░██   ░██ ░██  ░██  ░██  
" ░██      ███░░██████  █████       ░░█████ ░░██████  ███  ░██  ░██  
" ░░      ░░░  ░░░░░░  ░░░░░         ░░░░░   ░░░░░░  ░░░   ░░   ░░   
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

" deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}

" neomake {{{
call neomake#configure#automake('nrwi', 500)
" }}}

" lua config {{{
if (has("termguicolors"))
  set termguicolors
endif
lua << EOF
local lspconfig  = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.intelephense.setup{}

require('gitsigns').setup()
require('colorizer').setup()
local lualine = require('lualine')
lualine.status()
lualine.theme = 'nord'

local saga = require('lspsaga')
saga.init_lsp_saga()

require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "c", "cpp", "java", "json", "css", "python", "toml", "query", "lua" },
	highlight = {
		enable = true,
		custom_captures = {
			["include"] = "Keyword",
			["attribute_item.meta_item.identifier"] = "PreProc"
		}
	},
	playground = {
		enable = true
	}
}

EOF
" }}}

" nvim-compe {{{
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:true
let g:compe.source.treesitter = v:true

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" }}}

" lspsaga {{{

nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>gr :Lspsaga rename<CR>
nnoremap <silent><leader>gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>K :Lspsaga hover_doc<CR>

nnoremap <silent> <C-f> <cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>
"}}}

" nord-vim {{{
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1

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
