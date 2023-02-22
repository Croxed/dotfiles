local M = {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000
}

function M.config()
    local nord = require("nord")
    nord.setup({border=false})
    vim.cmd([[colorscheme nord]])

    vim.cmd([[
        syntax on
        filetype on
        filetype plugin indent on
    ]])
end

return M
