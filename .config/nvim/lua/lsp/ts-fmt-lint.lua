-- Example configuations here: https://github.com/mattn/efm-langserver
local M = {}

M.setup = function()
	local root_dir = require("project_nvim.project").find_lsp_root() or ""

	local get_linter_instance = function()
		-- prioritize local instance over global
		local local_instance = root_dir .. "/node_modules/.bin/" .. O.lang.tsserver.linter
		if vim.fn.executable(local_instance) == 1 then
			return local_instance
		end
		return O.lang.tsserver.linter
	end

	local tsserver_args = {}
	local formattingSupported = false

	if O.lang.tsserver.linter == "eslint" or O.lang.tsserver.linter == "eslint_d" then
		local eslint = {
			lintCommand = get_linter_instance() .. " -f visualstudio --stdin --stdin-filename ${INPUT}",
			lintStdin = true,
			lintFormats = {
				"%f(%l,%c): %tarning %m",
				"%f(%l,%c): %trror %m",
			},
			lintSource = O.lang.tsserver.linter,
			lintIgnoreExitCode = true,
		}
		table.insert(tsserver_args, eslint)
		-- Only eslint_d supports --fix-to-stdout
		if string.find(get_linter_instance(), "eslint_d") then
			formattingSupported = true
			local eslint_fix = {
				formatCommand = get_linter_instance() .. " --fix-to-stdout --stdin --stdin-filename ${INPUT}",
				formatStdin = true,
			}
			table.insert(tsserver_args, eslint_fix)
		end
	end
end

return M
