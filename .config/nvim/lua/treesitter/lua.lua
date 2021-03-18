require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "c", "cpp", "javascript", "typescript", "java", "json", "css", "python", "toml", "query", "lua" },
	highlight = {
		enable = true,
		custom_captures = {
			["include"] = "Keyword",
			["attribute_item.meta_item.identifier"] = "PreProc"
		}
	},
	playground = {
		enable = true
	}
}
