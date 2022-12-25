cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
g = vim.g -- a table to access global variables
scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local M = {}

-- Show icons in autocomplete
require('vim.lsp.protocol').CompletionItemKind = {
	'', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ',
	'﬌ ', ' ', ' ', '', ' ', ' ', ' ', ' ', '', '', '<>'
  }

vim.lsp.handlers['textDocument/publishDiagnostics'] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {spacing = 5, severity_limit = 'Warning'},
	update_in_insert = true
})

function M.has_neovim_v05()
	if fn.has("nvim-0.5") == 1 then
		return true
	end
	return false
end

function M.is_root()
	local output = vim.fn.systemlist("id -u")
	return ((output[1] or "") == "0")
end

function M.is_darwin()
	local os_name = vim.loop.os_uname().sysname
	return os_name == "Darwin"
	--[[ local output = vim.fn.systemlist "uname -s"
    return not not string.find(output[1] or "", "Darwin") ]]
end

function M.shell_type(file)
	if vim.fn.executable(file) == 1 then
		return true
	else
		return false
	end
end

function M.define_augroups(definitions) -- {{{1
	-- Create autocommand groups based on the passed definitions
	--
	-- The key will be the name of the group, and each definition
	-- within the group should have:
	--    1. Trigger
	--    2. Pattern
	--    3. Text
	-- just like how they would normally be defined from Vim itself
	for group_name, definition in pairs(definitions) do
		vim.cmd("augroup " .. group_name)
		vim.cmd("autocmd!")

		for _, def in pairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.cmd(command)
		end

		vim.cmd("augroup END")
	end
end

function M.check_lsp_client_active(name)
	local clients = vim.lsp.get_active_clients()
	for _, client in pairs(clients) do
		if client.name == name then
			return true
		end
	end
	return false
end
return M
