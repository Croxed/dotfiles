local M = {}

M.config = function()
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

	require("lspconfig").svelte.setup({
		cmd = { require('utils.lua').get_lsp_client_cmd('svelte') },
		filetypes = { "svelte" },
		root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
		on_attach = require("lsp").common_on_attach,
		capabilities = require('lsp').get_capabilities(),
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
