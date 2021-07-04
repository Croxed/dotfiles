
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
elseif executable('win32yank.exe')
      let g:clipboard = {
      \ 'name': 'win32yank',
      \ 'copy': {
      \    '+': 'win32yank.exe -i --crlf',
      \    '*': 'win32yank.exe -i --crlf',
      \  },
      \ 'paste': {
      \    '+': 'win32yank.exe -o --lf',
      \    '*': 'win32yank.exe -o --lf',
      \ },
      \ 'cache_enabled': 0,
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

"}}}
