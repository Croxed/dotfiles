local M = {}

M.config = function()
	O.lang.graphql = {
		lsp = {
			path = "graphql-lsp",
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
	require("utils.lua").setup_lsp('graphql')
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
