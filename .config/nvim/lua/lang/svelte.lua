local coq_present, coq = pcall(require, "coq")
if not coq_present then
 return {}
end
local M = {}

M.config = function()
	O.lang.svelte = {
		lsp = {
			path = DATA_PATH .. "/lspinstall/svelte/node_modules/.bin/svelteserver",
		},
	}
end

M.format = function()
	-- TODO: implement formatter (if applicable)
	return "No formatter configured!"
end

M.lint = function()
	-- TODO: implement linters (if applicable)
	return "No linters configured!"
end

M.lsp = function()
	if require("utils.lua").check_lsp_client_active("svelte") then
		return
	end

	require("lspconfig").svelte.setup(coq.lsp_ensure_capabilities({
		cmd = { O.lang.svelte.lsp.path, "--stdio" },
		filetypes = { "svelte" },
		root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
		on_attach = require("lsp").common_on_attach,
	}))
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
