cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
g = vim.g -- a table to access global variables
scopes = { o = vim.o, b = vim.bo, w = vim.wo }

if not vim.notify then
	vim.notify = print
end

if not vim.log then
	vim.log = { "levels" }
	vim.log.levels = { "Error", "Info", "Warning" }
end
function opt(scope, key, value)
	scopes[scope][key] = value
	if scope ~= "o" then
		scopes["o"][key] = value
	end
end
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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

local language_servers = {
	sumneko_lua = {
		config = function(opts)
		opts = vim.tbl_deep_extend("force", {
			settings = {
			Lua = {
				runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
				diagnostics = {globals = {'vim'}},
				workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
				},
				telemetry = {enable = false}
			}
			}

		}, opts)
		return opts
		end
	},
	jsonls = {
		config = function(opts)
		opts = vim.tbl_deep_extend("force", {
			settings = {json = {schemas = require('schemastore').json.schemas()}}
		}, opts)
		return opts
		end
	}
}

function M.get_lsp_client_cmd(server)
	local present, lsp_install = pcall(require, 'nvim-lsp-installer.servers')
	if present then
		local ok, server_conf = lsp_install.get_server(server)
		if ok then
			if not server_conf:is_installed() then
				server_conf:install()
			end
			return server_conf:get_default_options().cmd
		end
	end
end

local present, lsp_install = pcall(require, 'nvim-lsp-installer')
if present then
	lsp_install.on_server_ready(function(server) 
		local capabilities = require('lsp').get_capabilities()	
		local opts = {capabilities = capabilities}
		if language_servers[server.name] then
			opts = language_servers[server.name].config(opts)
		end
		server:setup(opts)
	end)
end
function M.install_if_missing(server)
	local present, lsp_install_servers = pcall(require, 'nvim-lsp-installer.servers')
	if present then
		local ok, server_conf = lsp_install_servers.get_server(server)
		if ok then
			if not server_conf:is_installed() then
				server_conf:install()
			end
		end
	end
end

local lsp_config
function M.setup_lsp(server, server_conf)
	if not lsp_config then
		lsp_config = require('lspconfig')
	end

	if M.check_lsp_client_active(server) then
		return
	end
	M.install_if_missing(server)
end

return M
