# Neovim config

Personal configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), using native `vim.pack` and the Catppuccin Macchiato colorscheme.

`init.lua` is a small, ordered entry point. Core editor settings live under `lua/config`, while plugin configuration is grouped by responsibility under `lua/config/plugins`. Kickstart's optional plugin modules remain under `lua/kickstart/plugins`.

Update plugins inside Neovim with `:lua vim.pack.update()`.
