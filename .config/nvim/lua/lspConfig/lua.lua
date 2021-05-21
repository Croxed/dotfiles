require('utils.lua')
require("nvimTree.lua")
opt('o', 'termguicolors', true)

local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
})

local lspconfig  = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.intelephense.setup{}
lspconfig.sumneko_lua.setup(luadev)
