local M = {}

M.config = function()
	O.lang.go = {
		formatter = {
			exe = "gofmt",
			args = {},
			stdin = true,
		},
		linters = {
			"golangcilint",
			"revive",
		},
		lsp = {
			path = DATA_PATH .. "/lspinstall/go/gopls",
		},
	}
end

M.format = function()
	O.formatters.filetype["go"] = {
		function()
			return {
				exe = O.lang.go.formatter.exe,
				args = O.lang.go.formatter.args,
				stdin = O.lang.go.formatter.stdin,
			}
		end,
	}

	require("formatter.config").set_defaults({
		logging = false,
		filetype = O.formatters.filetype,
	})
end

M.lint = function()
	require("lint").linters_by_ft = {
		go = O.lang.go.linters,
	}
end

M.lsp = function()
	if not require("utils.lua").check_lsp_client_active("gopls") then
		require("lspconfig").gopls.setup({
			cmd = { O.lang.go.lsp.path },
			settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
			root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
			init_options = { usePlaceholders = true, completeUnimported = true },
			on_attach = require("lsp").common_on_attach,
		})
	end
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
