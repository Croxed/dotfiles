CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

O = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'nord',
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = false,
    shell = 'bash',
	  timeoutlen = 100,
    nvim_tree_disable_netrw = 0, 

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = {"bash", "css", "dockerfile", "html", "go", "java", "javascript", "json", "php", "python", "typescript", "vue", "yaml"},
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        playground = {enabled = true},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},
    python = {
        linter = '',
        -- @usage can be 'yapf', 'black'
        formatter = '',
        autoformat = false,
        isort = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true},
		analysis = {type_checking = "basic", auto_search_paths = true, use_library_code_types = true}
    },
    dart = {sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'},
    lua = {
        -- @usage can be 'lua-format'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    sh = {
        -- @usage can be 'shellcheck'
        linter = 'shellcheck',
        -- @usage can be 'shfmt'
        formatter = 'shfmt',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    tsserver = {
        -- @usage can be 'eslint'
        linter = '',
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    json = {
        -- @usage can be 'prettier'
        formatter = '',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    tailwindls = {filetypes = {'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}},
    clang = {diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}},
	ruby = {
		diagnostics = {virtualtext = {spacing = 0, prefix = ""}, signs = true, underline = true},
		filetypes = {'rb', 'erb', 'rakefile'}
	},
    go = {},
    -- css = {formatter = '', autoformat = false, virtual_text = true},
    -- json = {formatter = '', autoformat = false, virtual_text = true}
}
