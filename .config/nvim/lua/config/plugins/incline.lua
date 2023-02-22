local M = {
  "b0o/incline.nvim",
  event = "BufReadPre",
}

function M.config()
  if vim.g.started_by_firenvim then
    return
  end

  local colors = require("nord.colors")

  require("incline").setup({
    highlight = {
      groups = {
        InclineNormal = {
          guibg = colors.palette.snow_storm.origin,
          guifg = colors.default_bg,
          -- gui = "bold",
        },
        InclineNormalNC = {
          guifg = colors.palette.snow_storm.origin,
          guibg = colors.default_bg,
        },
      },
    },
    window = {
      margin = {
        vertical = 0,
        horizontal = 1,
      },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local icon, color = require("nvim-web-devicons").get_icon_color(filename)
      return {
        { icon, guifg = color },
        { " " },
        { filename },
      }
    end,
  })
end

return M
