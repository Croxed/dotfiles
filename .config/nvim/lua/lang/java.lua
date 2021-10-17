local M = {}

M.config = function()
	O.lang.java = {
		java_tools = {
			active = false,
		},
		formatter = {
			exe = "prettier",
			args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
		},
	}
end

M.format = function()
	local root_dir = require("project_nvim.project").find_lsp_root() or ""

	-- use the global prettier if you didn't find the local one
	local prettier_instance = root_dir .. "/node_modules/.bin/prettier"
	if vim.fn.executable(prettier_instance) ~= 1 then
		prettier_instance = O.lang.tsserver.formatter.exe
	end

	O.formatters.filetype["java"] = {
		function()
			return {
				exe = prettier_instance,
				-- TODO: allow user to override this
				args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
				stdin = true,
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
	if require("utils.lua").check_lsp_client_active("jdtls") then
		return
	end

	local util = require("lspconfig/util")

	require("lspconfig").jdtls.setup({
		on_attach = require("lsp").common_on_attach,
		cmd = require('utils.lua').get_lsp_client_cmd('jdtls'),
		filetypes = { "java" },
		root_dir = util.root_pattern({ ".git", "build.gradle", "pom.xml" }),
		capabilities = require('lsp').get_capabilities(),
		-- init_options = {bundles = bundles}
		-- on_attach = require'lsp'.common_on_attach
	})
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
