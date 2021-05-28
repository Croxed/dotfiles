-- npm i -g bash-language-server
require'lspconfig'.bashls.setup {
    cmd = {"bash-language-server", "start"},
    on_attach = require'lsp'.common_on_attach,
    filetypes = { "sh", "zsh" }
}
