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

local function server_available_and_not_installed(installed_servers, available_servers, server)
	if available_servers[server] and not installed_servers[server] then
		return 1
	else
		return 0
	end
end

local function install_missing_servers()
	local lspinstall = require("lspinstall")
	local installed_servers = lspinstall.installed_servers()
	local available_servers = lspinstall.available_servers()
	local required_servers = O.treesitter.ensure_installed

	for _, server in pairs(required_servers) do
		if not server_available_and_not_installed(installed_servers, available_servers, server) then
			lspinstall.install_server(server)
		end
	end
end

install_missing_servers()
