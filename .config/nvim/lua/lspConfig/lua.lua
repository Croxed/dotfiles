require('utils.lua')
require("nvimTree.lua")
opt('o', 'termguicolors', true)
local lspconfig  = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.intelephense.setup{}