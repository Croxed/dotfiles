local M = {}

M.config = function()
	O.lang.yaml = {
		formatter = {
			exe = "prettier",
			args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
			stdin = true,
		},
	}
end

M.format = function()
	O.formatters.filetype["yaml"] = {
		function()
			return {
				exe = O.lang.yaml.formatter.exe,
				args = O.lang.yaml.formatter.args,
				stdin = O.lang.yaml.formatter.stdin,
			}
		end,
	}
	require("formatter.config").set_defaults({
		logging = false,
		filetype = O.formatters.filetype,
	})
end

M.lint = function()
	-- TODO: implement linters (if applicable)
	return "No linters configured!"
end

M.lsp = function()
	require("utils.lua").setup_lsp('yamlls')
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
