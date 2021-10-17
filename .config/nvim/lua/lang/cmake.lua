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
	if require("utils.lua").check_lsp_client_active("cmake") then
		return
	end

	require("lspconfig").cmake.setup({
		cmd = require('utils.lua').get_lsp_client_cmd('cmake'),
		on_attach = require("lsp").common_on_attach,
		filetypes = { "cmake" },
		capabilities = require('lsp').get_capabilities()
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
