return {
    -- Pretty thinkgs
    "mistricky/codesnap.nvim",
    build = "make",
    event = "VeryLazy",
    enabled = true,
    config = function()
        codensap_path = os.getenv("HOME") .. "/.local/share/codesnap/"
        vim.fn.system({
            "mkdir",
            "-p",
            codensap_path
        })
        require("codesnap").setup({
            watermark = "Oscar Wennergren",
            save_path = codensap_path
        })
    end
}
