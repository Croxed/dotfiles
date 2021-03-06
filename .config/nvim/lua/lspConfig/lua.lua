require('utils.lua')
require("nvimTree.lua")
opt('o', 'termguicolors', true)
-- 1. get the config for this server from nvim-lspconfig and adjust the cmd path.
--    relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
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

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in ipairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
