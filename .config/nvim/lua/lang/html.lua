local M = {}

M.config = function()
	O.lang.html = {
		linters = {
			"tidy",
			-- https://docs.errata.ai/vale/scoping#html
			"vale",
		},
	}
end

M.format = function()
	-- TODO: implement formatters (if applicable)
	return "No formatters configured!"
end

M.lint = function()
	require("lint").linters_by_ft = {
		html = O.lang.html.linters,
	}
end

M.lsp = function()
	require("utils.lua").setup_lsp('html')
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
