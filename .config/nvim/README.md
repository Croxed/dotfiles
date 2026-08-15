# Neovim config

Personal configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), using native `vim.pack` and the Catppuccin Macchiato colorscheme.

The main configuration is intentionally kept in `init.lua`, following Kickstart's documented, single-file layout. Optional plugin examples live under `lua/kickstart/plugins` and personal additions can go in `lua/custom/plugins`.

Update plugins inside Neovim with `:lua vim.pack.update()`.
