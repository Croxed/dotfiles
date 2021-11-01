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
	require("utils.lua").setup_lsp('elmls', {
		init_options = {
			elmAnalyseTrigger = "change",
			elmFormatPath = O.lang.elm.lsp.format,
			elmPath = O.lang.elm.lsp.root,
			elmTestPath = O.lang.elm.lsp.test,
		},
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
