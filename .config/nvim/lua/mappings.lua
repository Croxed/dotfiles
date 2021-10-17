local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local cmd = vim.cmd
local opt = {}

vim.g.mapleader = " "

-- toggle numbers
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- Truezen.nvim
map("n", "<leader>tz", [[<Cmd>TZAtaraxis<CR>]], opt) --ataraxis

-- Commenter Keybinding
map("n", "<leader>/", ":CommentToggle<CR>", opt)
map("v", "<leader>/", ":CommentToggle<CR>", opt)

-- NvimTree
map("n", "<leader>op", ":NvimTree<CR>", opt)

map("i", "jk", "<esc>") --jk to exit
map("c", "jk", "<C-C>")
map("n", ";", ":") --semicolon to enter command mode
map("n", "j", "gj") --move by visual line not actual line
map("n", "k", "gk")
map("n", "<leader>ww", [[<Cmd>HopWord<CR>]], opt) --easymotion/hop
map("n", "<leader>l", [[<Cmd>HopLine<CR>]], opt)
map("n", "<leader>fP", [[<Cmd>e ~/.config/nvim/init.lua<CR>]], opt)

map("n", "<c-k>", [[<Cmd>wincmd k<CR>]], opt) --ctrlhjkl to navigate splits
map("n", "<c-j>", [[<Cmd>wincmd j<CR>]], opt)
map("n", "<c-h>", [[<Cmd>wincmd h<CR>]], opt)
map("n", "<c-l>", [[<Cmd>wincmd l<CR>]], opt)

cmd([[autocmd BufWritePre * %s/\s\+$//e]]) --remove trailing whitespaces
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

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


_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t("<C-p>")
	elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
		return t("<Plug>(vsnip-jump-prev)")
	else
		return t("<S-Tab>")
	end
end

-- Telescope
map("n", "<Leader>gt", [[<Cmd> Telescope git_status <CR>]], opt)
map("n", "<Leader>cm", [[<Cmd> Telescope git_commits <CR>]], opt)
map("n", "<Leader>.", [[<Cmd> Telescope find_files <CR>]], opt)
map("n", "<Leader>bb", [[<Cmd>Telescope buffers<CR>]], opt)
map("n", "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], opt)
map("n", "<Leader>fr", [[<Cmd>Telescope oldfiles<CR>]], opt)

-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)

--nvimTree
map("n", "<Leader>o", ":NvimTreeToggle<CR>", opt)

--lsp

map("n", "<Leader>gd", [[":lua vim.lsp.buf.definition()<CR>"]], opt)
map("n", "<Leader>gD", [[":lua vim.lsp.buf.declaration()<CR>"]], opt)
map("n", "<Leader>gr", [[":lua vim.lsp.buf.references()<CR>"]], opt)
map("n", "<Leader>gi", [[":lua vim.lsp.buf.implementation()<CR>"]], opt)

map("n", "K", ":lua vim.lsp.buf.hover()<CR>", opt)
map("n", "<C-p>", ":lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>", opt)
map("n", "<C-n>", ":lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>", opt)
