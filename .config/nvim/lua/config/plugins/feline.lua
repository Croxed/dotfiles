local M = {
  "freddiehaddad/feline.nvim",
  event = "VeryLazy"
}

function M.config()
local lsp = require("feline.providers.lsp")
local vi_mode_utils = require('feline.providers.vi_mode')
local colors = require("nord.colors")
local nord = {
  default_fg = colors.palette.snow_storm.origin,
  default_bg = colors.default_bg,
  colors = {
      fore = colors.palette.polar_night.brightest,
      back = colors.palette.default_bg,
      dark = colors.palette.polar_night.brighter,
      white = colors.palette.snow_storm.brightest,
      skyblue = colors.palette.frost.polar_water,
      cyan = colors.palette.aurora.green,
      green = colors.palette.frost.ice,
      oceanblue = colors.palette.frost.artic_ocean,
      magenta = colors.palette.aurora.purple,
      orange = colors.palette.aurora.orange,
      red = colors.palette.snow_storm.brightest,
      violet = colors.palette.aurora.purple,
      yellow = colors.palette.aurora.yellow
  }
}
local gps = require("nvim-navic")
local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local winbar_components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}


local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  CONFIRM = 'red',
  VISUAL = 'skyblue',
  LINES = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = '<|',
  OP = '<|',
  INSERT = '|>',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = '<|',
  SHELL = '<|',
  TERM = '<|',
  NONE = '<>',
  CONFIRM = '|>'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'lazy',
  'startify',
  'fugitive',
  'fugitiveblame'
}
force_inactive.buftypes = {
  'terminal'
}


local statusline_style = {
  left = " ",
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}
-- STATUSLINE
-- LEFT

-- vi-mode
components.active[1][1] = {
  provider = statusline_style.main_icon,
  hl = function()
    local val = {}

    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'black'
    val.style = 'bold'

    return val
  end,
  right_sep = ' '
}
-- vi-symbol
components.active[1][2] = {
  provider = function()
    return vi_mode_text[vi_mode_utils.get_vim_mode()]
  end,
  hl = function()
    local val = {}
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}
-- filename
components.active[1][3] = {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  }
}


components.active[1][4] = {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist("ERROR")
  end,
  hl = { fg = "red" },
  icon = "  ",
}

components.active[1][5] = {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist("WARN")
  end,
  hl = { fg = "yellow" },
  icon = "  ",
}

components.active[1][6] = {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist("HINT")
  end,
  hl = { fg = "grey_fg2" },
  icon = "  ",
}

components.active[1][7] = {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist("INFO")
  end,
  hl = { fg = "green" },
  icon = "  ",
}

-- MID

components.active[2][1] = {
  provider = function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    if Lsp then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = {
        "",
        "",
        "",
      }

      local success_icon = {
        "",
        "",
        "",
      }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      else
        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end
    end
    return ""
  end,
  hl = { fg = "green" },
}

-- gitBranch
components.active[2][2] = {
  provider = 'git_branch',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffAdd
components.active[2][3] = {
  provider = 'git_diff_added',
  hl = {
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffModfified
components.active[2][4] = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffRemove
components.active[2][5] = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  },
}

-- RIGHT

-- fileIcon
components.active[3][1] = {
  provider = function()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon == nil then
      icon = ''
    end
    return icon
  end,
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}
-- fileType
components.active[3][2] = {
  provider = 'file_type',
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}
-- fileSize
components.active[3][3] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileFormat
components.active[3][4] = {
  provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileEncode
components.active[3][5] = {
  provider = 'file_encoding',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
components.active[3][6] = {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- linePercent
components.active[3][7] = {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- Lazy.nvim
local lazy = require('lazy.status')
components.active[3][8] = {
  provider = function() return " ﮮ " end,
  enabled = lazy.has_updates,
  hl = {
    fg = 'black',
    bg = 'bg',
    style = 'bold'
  }
}
-- scrollBar
components.active[3][9] = {
  provider = 'scroll_bar',
  hl = {
    fg = 'yellow',
    bg = 'bg',
  },
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
}

-- WINBAR
-- LEFT

-- nvimGps
winbar_components.active[1][1] = {
  provider = function() return gps.get_location() end,
  enabled = function() return gps.is_available() end,
  hl = {
    fg = 'orange',
    style = 'bold'
  }
}

-- MID

-- RIGHT

-- LspName
winbar_components.active[3][1] = {
  provider = 'lsp_client_names',
  hl = {
    fg = 'yellow',
    style = 'bold'
  },
  right_sep = ' '
}
-- diagnosticErrors
winbar_components.active[3][2] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
  hl = {
    fg = 'red',
    style = 'bold'
  }
}
-- diagnosticWarn
winbar_components.active[3][3] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
  hl = {
    fg = 'yellow',
    style = 'bold'
  }
}
-- diagnosticHint
winbar_components.active[3][4] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
  hl = {
    fg = 'cyan',
    style = 'bold'
  }
}
-- diagnosticInfo
winbar_components.active[3][5] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}

-- INACTIVE

-- fileType
winbar_components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
}

require('feline').setup({
  theme = nord.colors,
  default_bg = nord.default_bg,
  default_fg = nord.default_fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
})

require('feline').winbar.setup({
  components = winbar_components,
  force_inactive = force_inactive,
})

end

return M