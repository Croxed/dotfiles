-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local cmd = vim.cmd
local opt = {}

-- toggle numbers
vim.keymap.set("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)
vim.keymap.set("i", "jk", "<esc>") --jk to exit
vim.keymap.set("c", "jk", "<C-C>")
vim.keymap.set("n", ";", ":") --semicolon to enter command mode
vim.keymap.set("n", "j", "gj") --move by visual line not actual line
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<c-k>", function() vim.cmd.wincmd('k') end) --ctrlhjkl to navigate splits
vim.keymap.set("n", "<c-j>", function() vim.cmd.wincmd('j') end)
vim.keymap.set("n", "<c-h>", function() vim.cmd.wincmd('h') end)
vim.keymap.set("n", "<c-l>", function() vim.cmd.wincmd('l') end)

cmd([[autocmd BufWritePre * %s/\s\+$//e]]) --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- move between tabs
vim.keymap.set("n", "<TAB>", vim.cmd.BufferLineCycleNext)
vim.keymap.set("n", "<S-TAB>", vim.cmd.BufferLineCyclePrev)

--lsp
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references)
vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>tr", vim.cmd.TroubleToggle)

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<C-p>", function() vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}}) end)
vim.keymap.set("n", "<C-n>", function() vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}}) end)