local M = {}

M.config = function()
	O.lang.lua = {
		diagnostics = {
			virtual_text = { spacing = 0, prefix = "" },
			signs = true,
			underline = true,
		},
		formatter = {
			exe = "stylua",
			args = {},
			stdin = false,
		},
		linters = { "luacheck" },
	}
end

M.format = function()
	O.formatters.filetype["lua"] = {
		function()
			return {
				exe = O.lang.lua.formatter.exe,
				args = O.lang.lua.formatter.args,
				stdin = O.lang.lua.formatter.stdin,
				tempfile_prefix = ".formatter",
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
		lua = O.lang.lua.linters,
	}
end

M.lsp = function()
	if not require("utils.lua").check_lsp_client_active("sumneko_lua") then
		-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

		local luadev = require('lua-dev').setup({
			lspconfig = {
				cmd = { require('utils.lua').get_lsp_client_cmd('sumneko_lua') },
				on_attach = require("lsp").common_on_attach,
				capabilities = require('lsp').get_capabilities(),
			}
		})

		require("lspconfig").sumneko_lua.setup(luadev)
	end
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
