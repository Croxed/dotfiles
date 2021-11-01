local M = {}

M.config = function()
	O.lang.vim = {
		linters = { "vint" },
	}
end

M.format = function()
	-- TODO: implement formatter for language
	return "No formatter available!"
end

M.lint = function()
	require("lint").linters_by_ft = {
		vim = O.lang.vim.linters,
	}
end

M.lsp = function()
	require("utils.lua").setup_lsp('vimls')
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
