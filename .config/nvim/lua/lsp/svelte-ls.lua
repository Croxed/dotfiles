-- TODO: what is a svelte filetype
require("lspconfig").svelte.setup({
	cmd = require('utils.lua').get_lsp_client_cmd('svelte'),
	on_attach = require("lsp").common_on_attach,
})
