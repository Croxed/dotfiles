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
	if require("utils.lua").check_lsp_client_active("vimls") then
		return
	end

	-- npm install -g vim-language-server
	require("lspconfig").vimls.setup({
		cmd = { require('utils.lua').get_lsp_client_cmd('vimls') },
		on_attach = require("lsp").common_on_attach,
		capabilities = require('lsp').get_capabilities(),
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
