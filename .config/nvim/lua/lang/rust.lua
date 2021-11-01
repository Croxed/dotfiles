local M = {}

M.config = function()
	O.lang.rust = {
		rust_tools = {
			active = false,
			parameter_hints_prefix = "<-",
			other_hints_prefix = "=>", -- prefix for all the other hints (type, chaining)
		},
		-- @usage can be clippy
		formatter = {
			exe = "rustfmt",
			args = { "--emit=stdout", "--edition=2018" },
			stdin = true,
		},
		linter = "",
		diagnostics = {
			virtual_text = { spacing = 0, prefix = "" },
			signs = true,
			underline = true,
		},
	}
end

M.format = function()
	O.formatters.filetype["rust"] = {
		function()
			return {
				exe = O.lang.rust.formatter.exe,
				args = O.lang.rust.formatter.args,
				stdin = O.lang.rust.formatter.stdin,
			}
		end,
	}

	require("formatter.config").set_defaults({
		logging = false,
		filetype = O.formatters.filetype,
	})
end

M.lint = function()
	-- TODO: implement linters (if applicable)
	return "No linters configured!"
end

M.lsp = function()
	require("utils.lua").setup_lsp('rust_analyzer', {
		root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json"),
		filetypes = { "rust" },
	})
	-- TODO: fix these mappings
	vim.api.nvim_exec(
		[[
    autocmd Filetype rust nnoremap <leader>lm <Cmd>RustExpandMacro<CR>
    autocmd Filetype rust nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>
    autocmd Filetype rust nnoremap <leader>le <Cmd>RustRunnables<CR>
    autocmd Filetype rust nnoremap <leader>lh <Cmd>RustHoverActions<CR>
    ]],
		true
	)
end

M.dap = function()
	-- TODO: implement dap
	return "No DAP configured!"
end

return M
