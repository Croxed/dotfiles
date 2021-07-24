local present, ts_config = pcall(require, "nvim-treesitter.configs")
local present2, _ = pcall(require, "globals")
if not present or not present2 then
    return
end

ts_config.setup {
        ensure_installed = O.treesitter.ensure_installed,
        ignore_install = O.treesitter.ignore_install,
        highlight = {
            enable = true,
            use_languagetree = true
        }
    }
