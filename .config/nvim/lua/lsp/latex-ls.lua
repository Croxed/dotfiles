require'lspconfig'.texlab.setup{
    cmd = {"texlab"},
    on_attach = require'lsp'.common_on_attach
}
