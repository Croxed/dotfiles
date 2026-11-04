# zsh config layout & pitfalls
- ~/.zshrc (zimfw + p10k) sources ~/.zsh/.zsh-config/init.zsh (plugins/*.zsh, settings/*.zsh, deja, zsh-patina); both tracked in ~/.dotfiles.
- zoxide is loaded via zsh-defer, so `cd` wrapper must fall back to `builtin cd` until `z` exists.
- PATH's `typeset -U` attribute gets lost in the plugin chain; dedupe is re-applied at the end of .zshrc.
- GOPATH/SDKMAN_DIR must be exported before init.zsh is sourced.
- Startup baseline: ~80ms (`/usr/bin/time zsh -ic exit`).
