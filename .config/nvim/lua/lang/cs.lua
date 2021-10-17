local M = {}

M.config = function()
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
	if require("utils.lua").check_lsp_client_active("omnisharp") then
		return
	end

	-- C# language server (csharp/OmniSharp) setup
	require("lspconfig").omnisharp.setup({
		on_attach = require("lsp").common_on_attach,
		cmd = require('utils.lua').get_lsp_client_cmd('omnisharp') .. "--languageserver" .. "--hostPID" .. tostring(vim.fn.getpid()),
		capabilities = require('lsp').get_capabilities(),
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
