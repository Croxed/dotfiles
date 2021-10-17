
local modules = {
	"pluginList",
	"plugins.bufferline",
	"mappings",
	"utils",
}

local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

require("options")

for i = 1, #modules, 1 do
	local ok, res = xpcall(require, debug.traceback, modules[i])
	if not ok then
		print("Error loading module : " .. modules[i])
		print(res) -- print stack traceback of the error
	end
end
