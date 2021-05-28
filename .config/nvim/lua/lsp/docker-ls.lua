-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup {
    cmd = {"docker-langserver", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
	root_dir = vim.loop.cwd
}
