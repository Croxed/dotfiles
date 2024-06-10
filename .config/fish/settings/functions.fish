
# shell helper functions
# mostly written by Nathaniel Maia, some pilfered from around the web

# reloads the shell
function reload
    exec $SHELL $SHELL_ARGS "$argv"
end