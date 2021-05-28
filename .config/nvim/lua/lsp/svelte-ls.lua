require'lspconfig'.svelte.setup {
    cmd = {"svelteserver", "--stdio"},
    on_attach = require'lsp'.common_on_attach
}
