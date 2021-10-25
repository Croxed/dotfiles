local root_dir = require("project_nvim.project").find_lsp_root() or ""

-- use the global prettier if you didn't find the local one
local prettier_instance = root_dir .. "/node_modules/.bin/prettier"
if vim.fn.executable(prettier_instance) ~= 1 then
	prettier_instance = O.lang.tsserver.formatter.exe
end

O.formatters.filetype["javascriptreact"] = {
	function()
		local args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) }
		local extend_args = O.lang.tsserver.formatter.args

		if extend_args then
			for i = 1, #extend_args do
				table.insert(args, extend_args[i])
			end
		end

		return {
			exe = prettier_instance,
			args = args,
			stdin = true,
		}
	end,
}
O.formatters.filetype["javascript"] = O.formatters.filetype["javascriptreact"]
O.formatters.filetype["typescript"] = O.formatters.filetype["javascriptreact"]
O.formatters.filetype["typescriptreact"] = O.formatters.filetype["javascriptreact"]

require("formatter.config").set_defaults({
	logging = false,
	filetype = O.formatters.filetype,
})

if require("utils.lua").check_lsp_client_active("tsserver") then
	return
end

-- npm install -g typescript typescript-language-server
-- require'snippets'.use_suggested_mappings()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- local on_attach_common = function(client)
-- print("LSP Initialized")
-- require'completion'.on_attach(client)
-- require'illuminate'.on_attach(client)
-- end

require("lspconfig").tsserver.setup({
	cmd = require('utils.lua').get_lsp_client_cmd('tsserver'),
	on_attach = require("lsp").common_on_attach,
	capabilities = require('lsp').get_capabilities(),
})


require("lsp.ts-fmt-lint").setup()
