"
"              ██
"             ░░
"     ██    ██ ██ ██████████  ██████  █████
"    ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"    ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ██ ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
" ░██  ░░██   ░██ ███ ░██ ░██░███   ░░█████
"░░    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
"
" Source any configuration 
runtime! conf/**.vim

" Add everything related to plugins to runtime
" runtime plug/plug.vim
lua require('plugins')
lua require('plugin_config')
runtime plug/config.vim

" Source the UI config
runtime! ui/**.vim
