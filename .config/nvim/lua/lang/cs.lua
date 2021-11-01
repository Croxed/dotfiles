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
	require('utils.lua').setup_lsp('omnisharp')
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
