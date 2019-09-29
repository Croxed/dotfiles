
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

" lightline.vim {{{
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch' ], [ 'filename' ], [ 'bufferline' ] ],
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
            \   'gitbranch': 'LightLineGitbranch',
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

function! LightLineGitbranch()
    if winwidth(0) > 90 && &ft !~? s:except_ft && exists("*gitbranch#name")
        let _ = gitbranch#name()
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

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"}}}

" neomake {{{
let g:neomake_open_list = 0
let g:neomake_java_enabled_makers=['mvn']
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 100)

autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
			\   q :cclose<cr>:lclose<cr>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
			\   bd|
			\   q | endif

" }}}

" nord-vim {{{
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_uniform_diff_background = 1
let g:nord_cursor_line_number_background = 1

" }}}

" denite {{{
" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry
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

" vim-gitgutter {{{
let g:gitgutter_grep = 'rg'
let g:gitgutter_highlight_lines = 0

" }}}

" twiggy {{{
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'
" }}}""

" nnn {{{
let g:nnn#layout = { 'left': '~20%' } " or right, up, down
" }}}

" gutentags {{{
let g:gutentags_cache_dir = expand('~/.cache/tags') 
" }}}

" kexokinase {{{
let g:Hexokinase_highlighters = [ 'sign_column' ]
" }}}
"}}}
