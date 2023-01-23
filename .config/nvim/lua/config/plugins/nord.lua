local M = {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000
}

function M.config()
    local g = vim.g
    --nord
    g.nord_style = "nord"
    g.nord_borders = false
    g.nord_contrast = false
    g.nord_cursorline_transparent = true

    -- Load the colorscheme
    vim.cmd([[colorscheme nord]])

    vim.cmd([[
        syntax on
        filetype on
        filetype plugin indent on
    ]])
end

return M