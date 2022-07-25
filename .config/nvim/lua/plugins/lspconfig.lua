local present, mason = pcall(require, 'mason')
local present2, mason_lspconfig = pcall(require, 'mason-lspconfig')
local util = require "lspconfig.util"
if not present or not present2 then
	vim.notify("Mason not installed")
	return
end

mason.setup()
mason_lspconfig.setup({ensure_installed = O.lsp.ensure_installed})
-- LSP
require("lsp")


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


mason_lspconfig.setup_handlers({
	function (server_name)
		local opts = {capabilities = require('lsp').get_capabilities(), on_attach = require("lsp").common_on_attach}
		if language_servers[server_name] then
		  opts = language_servers[server_name].config(opts)
		end
		require("lspconfig")[server_name].setup { opts = opts }
		vim.cmd [[ do User LspAttachBuffers ]]
	end
})