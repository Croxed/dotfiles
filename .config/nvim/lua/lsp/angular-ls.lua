-- TODO: find correct root filetype
-- :LspInstall angular
require("lspconfig").angularls.setup({
	on_attach = require("lsp").common_on_attach,
})
