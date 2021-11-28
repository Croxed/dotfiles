require("config.general")
local ok, filetype = pcall(require, 'filetype')
if ok then
    filetype.setup()
end