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
	require("utils.lua").setup_lsp('bashls', {
		filetypes = { "sh", "zsh", "bash" },
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
