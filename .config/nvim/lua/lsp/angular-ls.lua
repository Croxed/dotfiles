-- TODO: find correct root filetype
-- :LspInstall angular
require("lspconfig").angularls.setup({
	cmd = require('utils.lua').get_lsp_client_cmd('angularls'),
	on_attach = require("lsp").common_on_attach,
})
