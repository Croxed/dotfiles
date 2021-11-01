local M = {}

M.config = function()
	O.lang.json = {
		diagnostics = {
			virtual_text = { spacing = 0, prefix = "" },
			signs = true,
			underline = true,
		},
		formatter = {
			exe = "python",
			args = { "-m", "json.tool" },
			stdin = true,
		},
	}
end

M.format = function()
	O.formatters.filetype["json"] = {
		function()
			return {
				exe = O.lang.json.formatter.exe,
				args = O.lang.json.formatter.args,
				stdin = O.lang.json.formatter.stdin,
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
	require("utils.lua").setup_lsp('jsonls', {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
