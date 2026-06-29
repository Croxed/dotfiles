# Neovim config (vim.pack)

This config uses native `vim.pack` (Neovim 0.12+) instead of lazy.nvim/LazyVim.

## Notes

- Plugins declared in `lua/config/pack.lua`
- Runtime options/keymaps/autocmds live in `lua/config/options.lua`, `lua/config/keymaps.lua`, `lua/config/autocmds.lua`
- Lockfile managed by Neovim: `nvim-pack-lock.json`

## Update plugins

Inside Neovim:

```vim
:lua vim.pack.update()
```
