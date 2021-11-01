local M = {}

M.config = function()
	O.lang.cmake = {
		formatter = {
			exe = "clang-format",
			args = {},
		},
	}
end

M.format = function()
	-- TODO: implement formatters (if applicable)
	return "No formatters configured!"
end

M.lint = function()
	-- TODO: implement linters (if applicable)
	return "No linters configured!"
end

M.lsp = function()
	require("utils.lua").setup_lsp("cmake", {filetypes = {"cmake"}})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
