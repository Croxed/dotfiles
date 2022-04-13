local present_2, lsp_installer = pcall(require, 'nvim-lsp-installer')
local present, lsp_installer_servers = pcall(require, 'nvim-lsp-installer.servers')

if not present or not present_2 then
	return
end

-- LSP
require("lsp")
local function install_server(server)
  local ok, server_conf = lsp_installer_servers.get_server(server)
  if ok then
    if not server_conf:is_installed() then
      server_conf:install()
    end
  end
end

local function install_missing_servers()
	local required_servers = O.lsp.ensure_installed

	for _, server in pairs(required_servers) do
		install_server(server)
	end
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


lsp_installer.on_server_ready(function(server)
  local opts = {capabilities = require('lsp').get_capabilities(), on_attach = require("lsp").common_on_attach}
  if language_servers[server.name] then
    opts = language_servers[server.name].config(opts)
  end
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local process = require "nvim-lsp-installer.process"
lsp_installer.lsp_attach_proxy = process.debounced(function()
  -- As of writing, if the lspconfig server provides a filetypes setting, it uses FileType as trigger, otherwise it uses BufReadPost
  vim.cmd("doautoall")
end)

install_missing_servers()
