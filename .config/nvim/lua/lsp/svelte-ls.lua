-- TODO: what is a svelte filetype
require("lspconfig").svelte.setup({
	on_attach = require("lsp").common_on_attach,
})
