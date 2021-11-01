local M = {}

M.config = function()
	O.lang.julia = {
		lsp = {
			path = CONFIG_PATH .. "/lua/lsp/julia/run.jl",
		},
	}
end

M.format = function()
	-- todo: implement formatters (if applicable)
	return "no formatters configured!"
end

M.lint = function()
	-- todo: implement linters (if applicable)
	return "no linters configured!"
end

M.lsp = function()
	require("utils.lua").setup_lsp('julials', {
		filetypes = { "julia" },
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
