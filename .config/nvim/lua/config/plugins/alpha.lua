local M = {
    'glepnir/dashboard-nvim',
    event = "VimEnter"
}

function M.config()
    local db = require('dashboard')
    local plugins = require("lazy").stats().count
    local footer = {'', "🎉 Neovim loaded " .. plugins .. " plugins "}
    db.custom_footer = footer
    db.custom_center = {
        {
            icon = "  ",
            desc = "New file                               ",
            shortcut = ":enew",
            action = "enew",
        },
        {
            icon = "  ",
            desc = "Find file                              ",
            shortcut = "SPC f",
            action = "Telescope find_files hidden=true no_ignore=true",
        },
        {
            icon = "  ",
            desc = "Browse dotfiles                        ",
            shortcut = "SPC v d",
            action = "Telescope find_files cwd=~/.config/nvim/ search_dirs=Ultisnips,lua,viml,init.vim",
        },
        {
            icon = "  ",
            desc = "Update plugins                         ",
            shortcut = ":Lazy update",
            action = "Lazy update",
        },
        {
            icon = "  ",
            desc = "Open floating terminal                 ",
            shortcut = "SPC t t",
            action = "FloatermToggle",
        },
        {
            icon = "  ",
            desc = "Close neovim                           ",
            shortcut = ":qa!",
            action = "qa!",
        },
    }
end

return M