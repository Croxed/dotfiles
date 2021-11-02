local present, lsp_install = pcall(require, 'nvim-lsp-installer.servers')
local present_2, lsp_installer = pcall(require, 'nvim-lsp-installer')

if not present or not present_2 then
	return
end

-- LSP
require("lsp")
local function install_server(server)
	local ok, server_cmd = lsp_install.get_server(server)
	if ok then
		if not server_cmd:is_installed() then
			server_cmd:install()
		end
	end
end

local function install_missing_servers()
	local required_servers = O.lsp.ensure_installed

	for _, server in pairs(required_servers) do
		install_server(server)
	end
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("lsp").common_on_attach,
    capabilities = require("lsp").get_capabilities(),
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local process = require "nvim-lsp-installer.process"
lsp_installer.lsp_attach_proxy = process.debounced(function()
  -- As of writing, if the lspconfig server provides a filetypes setting, it uses FileType as trigger, otherwise it uses BufReadPost
  vim.cmd("doautoall")
end)

install_missing_servers()
