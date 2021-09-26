local coq_present, coq = pcall(require, "coq")
if not coq_present then
 return {}
end
local M = {}

M.config = function()
	O.lang.terraform = {
		formatter = {
			exe = "terraform",
			args = { "fmt" },
			stdin = false,
		},
		lsp = {
			path = DATA_PATH .. "/lspinstall/terraform/terraform-ls",
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
	if require("utils.lua").check_lsp_client_active("terraformls") then
		return
	end

	require("lspconfig").terraformls.setup(coq.lsp_ensure_capabilities({
		cmd = { O.lang.terraform.lsp.path, "serve" },
		on_attach = require("lsp").common_on_attach,
		filetypes = { "tf", "terraform", "hcl" },
	}))
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
