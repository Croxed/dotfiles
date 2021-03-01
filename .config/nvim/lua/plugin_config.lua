local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

opt('o', 'termguicolors', true)
local lspconfig  = require('lspconfig')
lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.intelephense.setup{}

require('gitsigns').setup()
require('colorizer').setup()
local lualine = require('lualine')
lualine.status()
lualine.options.theme = 'nord'

local saga = require('lspsaga')
saga.init_lsp_saga()

require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "c", "cpp", "json", "css", "python", "toml", "query", "lua" },
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

require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = true;
        tags = true;
        snippets_nvim = true;
        treesitter = true;
    };
}

vim.fn['neomake#configure#automake']('nrwi', 500)
vim.lsp.callbacks['textDocument/publishDiagnostics'] = nil

map('i', '<silent><expr> <C-Space>', 'compe#complete()')
map('i', '<silent><expr> <CR>', "compe#confirm('<CR>')")
map('i', '<silent><expr> <C-e>', "compe#close('<C-e>')")
map('i', '<silent><expr> <C-f>', "compe#scroll({ 'delta': +4 })")
map('i', '<silent><expr> <C-d>', "compe#scroll({ 'delta': -4 })")


map('n', '<silent><leader>ca', ':Lspsaga code_action<CR>')
map('v', '<silent><leader>ca', ':<C-U>Lspsaga range_code_action<CR>')
map('n', '<silent><leader>gr', ':Lspsaga rename<CR>')
map('n', '<silent><leader>gh', ':Lspsaga lsp_finder<CR>')
map('n', '<silent><leader>K', ':Lspsaga hover_doc<CR>')

map('n', '<silent> <C-f>', "<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>")
map('n', '<silent> <C-b>', "<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>")

g['deoplete#enable_at_startup'] = 1
g['nord_italic'] = 1
g['nord_italic_comments'] = 1
g['nord_uniform_status_lines'] = 1
g['nord_uniform_diff_background'] = 1
g['nord_cursor_line_number_background'] = 1
