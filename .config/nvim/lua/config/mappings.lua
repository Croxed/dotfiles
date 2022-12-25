local cmd = vim.cmd
local opt = {}

vim.g.mapleader = " "

-- toggle numbers
vim.keymap.set("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- Truezen.nvim
vim.keymap.set("n", "<leader>tz", [[<Cmd>TZAtaraxis<CR>]], opt) --ataraxis

-- Commenter Keybinding
vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>", opt)
vim.keymap.set("v", "<leader>/", ":CommentToggle<CR>", opt)

-- NvimTree
vim.keymap.set("n", "<leader>op", ":NvimTree<CR>", opt)

vim.keymap.set("i", "jk", "<esc>") --jk to exit
vim.keymap.set("c", "jk", "<C-C>")
vim.keymap.set("n", ";", ":") --semicolon to enter command mode
vim.keymap.set("n", "j", "gj") --move by visual line not actual line
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<leader>ww", [[<Cmd>HopWord<CR>]], opt) --easymotion/hop
vim.keymap.set("n", "<leader>l", [[<Cmd>HopLine<CR>]], opt)
vim.keymap.set("n", "<leader>fP", [[<Cmd>e ~/.config/nvim/init.lua<CR>]], opt)

vim.keymap.set("n", "<c-k>", [[<Cmd>wincmd k<CR>]], opt) --ctrlhjkl to navigate splits
vim.keymap.set("n", "<c-j>", [[<Cmd>wincmd j<CR>]], opt)
vim.keymap.set("n", "<c-h>", [[<Cmd>wincmd h<CR>]], opt)
vim.keymap.set("n", "<c-l>", [[<Cmd>wincmd l<CR>]], opt)

cmd([[autocmd BufWritePre * %s/\s\+$//e]]) --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- compe stuff
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col(".") - 1
	if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		return true
	else
		return false
	end
end

-- Telescope
vim.keymap.set("n", "<Leader>gt", [[<Cmd> Telescope git_status <CR>]], opt)
vim.keymap.set("n", "<Leader>cm", [[<Cmd> Telescope git_commits <CR>]], opt)
vim.keymap.set("n", "<Leader>.", [[<Cmd> Telescope find_files <CR>]], opt)
vim.keymap.set("n", "<Leader>bb", [[<Cmd>Telescope buffers<CR>]], opt)
vim.keymap.set("n", "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], opt)
vim.keymap.set("n", "<Leader>fr", [[<Cmd>Telescope oldfiles<CR>]], opt)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- move between tabs
vim.keymap.set("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
vim.keymap.set("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

--nvimTree
vim.keymap.set("n", "<Leader>o", vim.cmd.Neotree, opt)

--lsp

vim.keymap.set("n", "<Leader>gd", [[":lua vim.lsp.buf.definition()<CR>"]], opt)
vim.keymap.set("n", "<Leader>gD", [[":lua vim.lsp.buf.declaration()<CR>"]], opt)
vim.keymap.set("n", "<Leader>gr", [[":lua vim.lsp.buf.references()<CR>"]], opt)
vim.keymap.set("n", "<Leader>gi", [[":lua vim.lsp.buf.implementation()<CR>"]], opt)

vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "<C-p>", ":lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>", opt)
vim.keymap.set("n", "<C-n>", ":lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>", opt)
