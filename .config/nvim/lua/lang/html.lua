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
	if not require("utils.lua").check_lsp_client_active("html") then
		-- npm install -g vscode-html-languageserver-bin
		local capabilities = require('lsp').get_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("lspconfig").html.setup({
			cmd = require('utils.lua').get_lsp_client_cmd('html'),
			on_attach = require("lsp").common_on_attach,
			capabilities = capabilities,
		})
	end
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
