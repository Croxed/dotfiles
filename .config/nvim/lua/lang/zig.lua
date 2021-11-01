local M = {}

M.config = function()
	O.lang.zig = {
		formatter = {
			exe = "zig",
			args = { "fmt" },
			stdin = false,
		},
		lsp = {
			path = "zls",
		},
	}
end

M.format = function()
	O.formatters.filetype["zig"] = {
		function()
			return {
				exe = O.lang.zig.formatter.exe,
				args = O.lang.zig.formatter.args,
				stdin = O.lang.zig.formatter.stdin,
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
	require("utils.lua").setup_lsp('zls', {
		root_dir = require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json"),
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
