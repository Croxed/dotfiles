return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    config = function()
        require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
}
