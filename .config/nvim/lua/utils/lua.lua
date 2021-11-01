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

function M.setup_efm()
	local vint = require "efm/vint"
	local stylua = require "efm/stylua"
	local golint = require "efm/golint"
	local goimports = require "efm/goimports"
	local black = require "efm/black"
	local isort = require "efm/isort"
	local flake8 = require "efm/flake8"
	local mypy = require "efm/mypy"
	local prettier = require "efm/prettier"
	local eslint = require "efm/eslint"
	local shellcheck = require "efm/shellcheck"
	local shfmt = require "efm/shfmt"
	local terraform = require "efm/terraform"

	local languages = {
		vim = { vint },
		lua = { stylua },
		go = { golint, goimports },
		python = { black, isort, flake8, mypy },
		typescript = { prettier, eslint },
		javascript = { prettier, eslint },
		typescriptreact = { prettier, eslint },
		javascriptreact = { prettier, eslint },
		yaml = { prettier },
		json = { prettier },
		html = { prettier },
		scss = { prettier },
		css = { prettier },
		markdown = { prettier },
		sh = { shellcheck, shfmt },
		zsh = { shfmt },
		terraform = { terraform },
	}

	M.setup_lsp('efm', {
		root_dir = vim.loop.cwd,
		filetypes = vim.tbl_keys(languages),
		settings = {
			rootMarkers = { ".git/" },
			languages = languages
		},
	})
end

local lsp_config
function M.setup_lsp(server, server_conf)
	if not lsp_config then
		lsp_config = require('lspconfig')
	end

	if M.check_lsp_client_active(server) then
		return
	end

	local conf = vim.deepcopy(server_conf or {})
	conf['cmd'] = M.get_lsp_client_cmd(server)
	conf['on_attach'] = require('lsp').common_on_attach
	conf['capabilities'] = require('lsp').get_capabilities()

	lsp_config[server].setup(conf)

	if server ~= 'efm' then
		M.setup_efm()
	end
end

return M
