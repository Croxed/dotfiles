local M = {}

M.config = function()
	O.lang.terraform = {
		formatter = {
			exe = "terraform",
			args = { "fmt" },
			stdin = false,
		},
	}
end

M.format = function()
	O.formatters.filetype["hcl"] = {
		function()
			return {
				exe = O.lang.terraform.formatter.exe,
				args = O.lang.terraform.formatter.args,
				stdin = O.lang.terraform.formatter.stdin,
				tempfile_prefix = ".formatter",
			}
		end,
	}
	O.formatters.filetype["tf"] = O.formatters.filetype["hcl"]

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
	require("utils.lua").setup_lsp('terraformls', {
		filetypes = { "tf", "terraform", "hcl" },
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
