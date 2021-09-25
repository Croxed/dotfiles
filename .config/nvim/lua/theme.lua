local g = vim.g

--nord
g.nord_style = "nord"
g.nord_borders = false
g.nord_contrast = false
g.nord_cursorline_transparent = true

-- Load the colorscheme
local present, nord = pcall(require, "nord")
if present then
	nord.set()
end

vim.cmd([[
    syntax on
    filetype on
    filetype plugin indent on
]])
