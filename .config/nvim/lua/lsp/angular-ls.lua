-- :LspInstall angular
require'lspconfig'.angularls.setup {
    cmd = {"ngserver", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
}
