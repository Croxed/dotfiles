require("globals.lua")
require("nvimTree.lua")
require("lspConfig.lua")
require("luaLine.lua")
require("whichKey.lua")
require("gitsigns").setup()
require("colorizer").setup()
require("lspsaga").init_lsp_saga()
require("treesitter.lua")
require("compe.lua")
require("utils.lua")
require('config')
require("bufferline").setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        mappings = "true"
    }
}

-- LSP
require("lsp")
require("lsp.angular-ls")
require("lsp.bash-ls")
require("lsp.clangd")
require("lsp.css-ls")
require("lsp.dart-ls")
require("lsp.docker-ls")
require("lsp.efm-general-ls")
require("lsp.elm-ls")
require("lsp.emmet-ls")
require("lsp.graphql-ls")
require("lsp.go-ls")
require("lsp.html-ls")
require("lsp.json-ls")
require("lsp.js-ts-ls")
require("lsp.kotlin-ls")
require("lsp.latex-ls")
require("lsp.lua-ls")
require("lsp.php-ls")
require("lsp.python-ls")
require("lsp.ruby-ls")
require("lsp.rust-ls")
require("lsp.svelte-ls")
require("lsp.terraform-ls")
require("lsp.vim-ls")
require("lsp.vue-ls")
require("lsp.yaml-ls")
require("lsp.elixir-ls")

-- Colors
require("lsp-colors").setup()

--vim.lsp.callbacks['textDocument/publishDiagnostics'] = nil