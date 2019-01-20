#!/bin/zsh

# expand escapes within the prompt
setopt prompt_subst

# allow comments in the shell
setopt interactivecomments

# Ctrl-d doesn't exit the terminal
setopt ignoreeof

# better cd handling
setopt autocd
setopt auto_pushd
setopt pushdminus
setopt pushd_ignore_dups

# completion
setopt nonomatch
setopt extendedglob
setopt completealiases

# history
setopt hist_verify
setopt share_history
setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_expire_dups_first

# job control
setopt auto_continue
setopt long_list_jobs

