local coq_present, coq = pcall(require, "coq")
if not coq_present then
 return {}
end
local M = {}

M.config = function()
	O.lang.docker = {
		lsp = {
			path = DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
		},
	}
end

M.format = function()
	-- TODO: implement formatter for language
	return "No formatter available!"
end

M.lint = function()
	-- TODO: implement linters (if applicable)
	return "No linters configured!"
end

M.lsp = function()
	if require("utils.lua").check_lsp_client_active("dockerls") then
		return
	end

	-- npm install -g dockerfile-language-server-nodejs
	require("lspconfig").dockerls.setup(coq.lsp_ensure_capabilities({
		cmd = { O.lang.docker.lsp.path, "--stdio" },
		on_attach = require("lsp").common_on_attach,
		root_dir = vim.loop.cwd,
	}))
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
