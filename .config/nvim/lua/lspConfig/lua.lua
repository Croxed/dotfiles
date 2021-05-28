require('utils.lua')
require("nvimTree.lua")
opt('o', 'termguicolors', true)

local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
})

