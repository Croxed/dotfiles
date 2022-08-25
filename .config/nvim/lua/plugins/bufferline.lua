local present, bufferline = pcall(require, "bufferline")
if not present then
	return
end

local bg = "#2e3440"
local bg2 = "#3b4252"
local bg3 = "#282c34"
local fg = "#CACed6"
local accent = "#81a1c1"
local accent2 = "#BF616A" -- Not saved
local accent3 = "#EBCB8B" -- Not saved

bufferline.setup({
	options = {
		numbers = "none",
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = "",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		offsets = {
			{
				filetype = "NvimTree",
				text = "Files",
			},
		},
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = "directory",
	},
	highlights = {
		fill = {
			bg = bg,
		},
		background = {
			bg = bg,
		},

		-- buffer
		buffer_selected = {
			fg = fg,
			bg = bg2,
		},
		separator = {
			fg = bg3,
			bg = bg,
		},
		separator_selected = {
			fg = bg3,
			bg = bg2,
		},
		separator_visible = {
			fg = bg2,
			bg = bg2,
		},
		indicator_selected = {
			fg = accent,
			bg = bg2,
		},

		-- tabs over right
		tab = {
			fg = fg,
			bg = bg,
		},
		tab_selected = {
			fg = accent,
			bg = bg2,
		},
		tab_close = {
			fg = accent,
			bg = bg2,
		},
		modified_selected = {
			fg = accent2,
			bg = bg2,
		},
		modified = {
			fg = accent3,
			bg = bg,
		},
		modified_visible = {
			fg = accent,
			bg = bg,
		},
	},
})
