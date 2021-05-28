-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
	cmd = {"yaml-language-server", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
}
