local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", opts = {}
}

M.event = "BufReadPre"

function M.config()
  require("ibl").setup()
end

return M
