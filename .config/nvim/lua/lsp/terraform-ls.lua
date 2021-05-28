require'lspconfig'.terraformls.setup{
    cmd = {"terraform-ls", "serve"},
    on_attach = require'lsp'.common_on_attach
}
