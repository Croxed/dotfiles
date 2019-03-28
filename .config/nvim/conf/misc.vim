
"              ██                
"             ░░                 
"  ██████████  ██  ██████  █████ 
" ░░██░░██░░██░██ ██░░░░  ██░░░██
"  ░██ ░██ ░██░██░░█████ ░██  ░░ 
"  ░██ ░██ ░██░██ ░░░░░██░██   ██
"  ███ ░██ ░██░██ ██████ ░░█████ 
" ░░░  ░░  ░░ ░░ ░░░░░░   ░░░░░  
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => autocmd/augroup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let g:lasttab = 1
augroup save_last_tab
    autocmd!
    autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Reload changes if file changed outside of vim requires autoread
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END

" when quitting a file, save the cursor position
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" when not running in a console or a terminal that doesn't support 256 colors
" enable cursorline in the currently active window and disable it in inactive ones
if $DISPLAY !=? '' && &t_Co == 256
    augroup cursorline
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Cleanup trailing spaces for relevant files
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" java completions
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" max line width for git commit messages
au FileType gitcommit set tw=72
"}}}
