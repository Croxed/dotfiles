local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
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
lualine.theme = 'nord'

local saga = require('lspsaga')
saga.init_lsp_saga()

require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "c", "cpp", "java", "json", "css", "python", "toml", "query", "lua" },
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