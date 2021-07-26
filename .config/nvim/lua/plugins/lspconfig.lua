local config = require("lspconfig").jdtls.document_config
require("lspconfig/configs").jdtls = nil -- important, unset the loaded config again
-- config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

-- 2. extend the config with an install_script and (optionally) uninstall_script
require("lspinstall/servers").jdtls = vim.tbl_extend("error", config, {
	-- lspinstall will automatically create/delete the install directory for every server
	install_script = [[
      git clone https://github.com/eclipse/eclipse.jdt.ls.git
      cd eclipse.jdt.ls
      ./mvnw clean verify -DskipTests
  ]],
	uninstall_script = nil, -- can be omitted
})

require("lspinstall/servers").kotlin = vim.tbl_extend("error", config, {
	install_script = [[
      git clone https://github.com/fwcd/kotlin-language-server.git language-server
      cd language-server
	  ./gradlew :server:installDist
  ]],
	uninstall_script = nil, -- can be omitted
})

-- LSP
require("lsp")
local function install_server(lspinstall, server)
	if lspinstall.available_servers()[server] and not lspinstall.installed_servers()[server] then
		print("Installing LSP server for " .. server)
		lspinstall.install_server(server)
	end
end

local function install_missing_servers()
	local lspinstall = require("lspinstall")
	local required_servers = O.lsp.ensure_installed

	for _, server in pairs(required_servers) do
		install_server(lspinstall, server)
	end
end

install_missing_servers()
