local g = vim.g

--nord
g.nord_style = "nord"
g.nord_borders = false
g.nord_contrast = false
g.nord_cursorline_transparent = true
require("nord").set()

vim.cmd([[
    syntax on
    filetype on
    filetype plugin indent on
]])
