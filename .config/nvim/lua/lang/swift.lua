local M = {}

M.config = function()
	O.lang.swift = {
		formatter = {
			exe = "swiftformat",
			args = {},
			stdin = true,
		},
		lsp = {
			path = "sourcekit-lsp",
		},
	}
end

M.format = function()
	-- TODO: implement formatter (if applicable)
	return "No formatter configured!"
end

M.lint = function()
	O.formatters.filetype["swift"] = {
		function()
			return {
				exe = O.lang.swift.formatter.exe,
				args = O.lang.swift.formatter.args,
				stdin = O.lang.swift.formatter.stdin,
			}
		end,
	}

	require("formatter.config").set_defaults({
		logging = false,
		filetype = O.formatters.filetype,
	})
end

M.lsp = function()
	if require("utils.lua").check_lsp_client_active("sourcekit") then
		return
	end

	require("lspconfig").sourcekit.setup({
		cmd = require('utils.lua').get_lsp_client_cmd('sourcekit'),
		on_attach = require("lsp").common_on_attach,
		filetypes = { "swift" },
		capabilities = require('lsp').get_capabilities(),
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
