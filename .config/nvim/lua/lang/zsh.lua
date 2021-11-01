local M = {}

M.config = function()
end

M.format = function()
	-- TODO: implement format for language
	return "No format available!"
end

M.lint = function()
	require("utils.lua").setup_efm()
end

M.lsp = function()
	if not require("utils.lua").check_lsp_client_active("bashls") then
		-- npm i -g bash-language-server
		require("lspconfig").bashls.setup({
			cmd = require('utils.lua').get_lsp_client_cmd('bashls'),
			on_attach = require("lsp").common_on_attach,
			filetypes = { "sh", "zsh" },
			capabilities = require('lsp').get_capabilities(),
		})
	end
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
