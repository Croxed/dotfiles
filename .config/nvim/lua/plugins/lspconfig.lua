local config = require'lspconfig'.jdtls.document_config
require'lspconfig/configs'.jdtls = nil -- important, unset the loaded config again
-- config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

-- 2. extend the config with an install_script and (optionally) uninstall_script
require'lspinstall/servers'.jdtls = vim.tbl_extend('error', config, {
    -- lspinstall will automatically create/delete the install directory for every server
    install_script = [[
      git clone https://github.com/eclipse/eclipse.jdt.ls.git
      cd eclipse.jdt.ls
      ./mvnw clean verify -DskipTests
  ]],
    uninstall_script = nil -- can be omitted
})

require'lspinstall/servers'.kotlin = vim.tbl_extend('error', config, {
    install_script = [[
      git clone https://github.com/fwcd/kotlin-language-server.git language-server
      cd language-server
	  ./gradlew :server:installDist
  ]],
    uninstall_script = nil -- can be omitted
})

-- LSP
require("lsp")
--[[require("lsp.angular-ls")
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
--]]