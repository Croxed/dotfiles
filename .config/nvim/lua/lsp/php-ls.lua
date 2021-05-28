require'lspconfig'.intelephense.setup {
    cmd = { "intelephense", "--stdio" },
    on_attach = require'lsp'.common_on_attach
}