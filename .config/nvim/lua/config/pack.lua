-- Native vim.pack plugin registry with LazyVim-style activation.
-- Keep the registry in startup, but don't put every plugin on the runtimepath.
local specs = {
  { name = "catppuccin", src = "https://github.com/catppuccin/nvim.git" },
  { name = "plenary.nvim", src = "https://github.com/nvim-lua/plenary.nvim.git" },
  { name = "nui.nvim", src = "https://github.com/MunifTanjim/nui.nvim.git" },
  { name = "which-key.nvim", src = "https://github.com/folke/which-key.nvim.git" },
  { name = "lualine.nvim", src = "https://github.com/nvim-lualine/lualine.nvim.git" },
  { name = "bufferline.nvim", src = "https://github.com/akinsho/bufferline.nvim.git" },
  { name = "nvim-tree.lua", src = "https://github.com/nvim-tree/nvim-tree.lua.git" },
  { name = "gitsigns.nvim", src = "https://github.com/lewis6991/gitsigns.nvim.git" },
  { name = "fzf-lua", src = "https://github.com/ibhagwan/fzf-lua.git" },
  { name = "mini.starter", src = "https://github.com/echasnovski/mini.starter.git" },
  { name = "mini.icons", src = "https://github.com/echasnovski/mini.icons.git" },
  { name = "nvim-notify", src = "https://github.com/rcarriga/nvim-notify.git" },
  { name = "mini.sessions", src = "https://github.com/echasnovski/mini.sessions.git" },
  { name = "noice.nvim", src = "https://github.com/folke/noice.nvim.git" },
  { name = "markdown-preview.nvim", src = "https://github.com/iamcco/markdown-preview.nvim.git" },
  { name = "vim-startuptime", src = "https://github.com/dstein64/vim-startuptime.git" },
  { name = "nvim-treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" },
  { name = "nvim-treesitter-context", src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git" },
  { name = "nvim-lspconfig", src = "https://github.com/neovim/nvim-lspconfig.git" },
  { name = "mason.nvim", src = "https://github.com/mason-org/mason.nvim.git" },
  { name = "mason-lspconfig.nvim", src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
  { name = "blink.lib", src = "https://github.com/Saghen/blink.lib.git" },
  { name = "blink.cmp", src = "https://github.com/Saghen/blink.cmp.git" },
  { name = "LuaSnip", src = "https://github.com/L3MON4D3/LuaSnip.git" },
  { name = "friendly-snippets", src = "https://github.com/rafamadriz/friendly-snippets.git" },
  { name = "conform.nvim", src = "https://github.com/stevearc/conform.nvim.git" },
  { name = "nvim-lint", src = "https://github.com/mfussenegger/nvim-lint.git" },
  { name = "trouble.nvim", src = "https://github.com/folke/trouble.nvim.git" },
  { name = "mini.comment", src = "https://github.com/echasnovski/mini.comment.git" },
  { name = "mini.surround", src = "https://github.com/echasnovski/mini.surround.git" },
  { name = "mini.hipatterns", src = "https://github.com/echasnovski/mini.hipatterns.git" },
  { name = "arborist.nvim", src = "https://github.com/arborist-ts/arborist.nvim" },
}

-- A no-op loader registers and installs packages without adding every package
-- directory to 'runtimepath'. `load = false` behaves like `:packadd!`, which
-- still exposes packages to Neovim's startup plugin scan and defeats laziness.
vim.pack.add(specs, { load = function() end, confirm = false })

local loaded = {}
local configured = {}
local function load(name)
  if not loaded[name] then
    vim.cmd.packadd(name)
    loaded[name] = true
  end
end

local function setup_once(name, fn)
  if configured[name] then
    return
  end
  load(name)
  fn()
  configured[name] = true
end

local function command(name, rhs, opts)
  vim.api.nvim_create_user_command(name, function(args)
    rhs(args)
  end, opts or {})
end

-- A small, lazy.nvim-inspired dashboard for the native package manager.
-- vim.pack remains responsible for all installs, updates, and deletes; this
-- buffer only provides a discoverable front end for those operations.
local pack_ui = {
  buf = nil,
  win = nil,
  filter = "",
  items = {},
  detail_start = 0,
}

local function pack_ui_close()
  if pack_ui.win and vim.api.nvim_win_is_valid(pack_ui.win) then
    local tab = vim.api.nvim_win_get_tabpage(pack_ui.win)
    if vim.api.nvim_get_current_tabpage() == tab and #vim.api.nvim_tabpage_list_wins(tab) == 1 then
      vim.cmd("tabclose")
    else
      vim.api.nvim_win_close(pack_ui.win, true)
    end
  end
  pack_ui.win, pack_ui.buf = nil, nil
end

local function pack_ui_current()
  if not pack_ui.win or not vim.api.nvim_win_is_valid(pack_ui.win) then
    return
  end
  local row = vim.api.nvim_win_get_cursor(pack_ui.win)[1] - 4
  return pack_ui.items[row]
end

local function pack_ui_details()
  if not pack_ui.buf or not vim.api.nvim_buf_is_valid(pack_ui.buf) then
    return
  end
  local item = pack_ui_current()
  local details = { "", "Details" }
  if item then
    local spec = item.spec
    details = {
      "",
      "Details",
      "  name:   " .. spec.name,
      "  source: " .. (spec.src or "unknown"),
      "  rev:    " .. (item.rev or "unknown"),
      "  path:   " .. (item.path or "unknown"),
      "  state:  " .. (item.active and "loaded in this session" or "not loaded"),
      "",
      "  u  update with vim.pack review buffer    d  delete if inactive",
      "  l  load with :packadd                    r  refresh",
    }
  else
    details = { "", "Details", "  No plugin matches the current filter." }
  end
  vim.bo[pack_ui.buf].modifiable = true
  vim.api.nvim_buf_set_lines(pack_ui.buf, pack_ui.detail_start - 1, -1, false, details)
  vim.bo[pack_ui.buf].modifiable = false
end

local function pack_ui_render()
  if not pack_ui.buf or not vim.api.nvim_buf_is_valid(pack_ui.buf) then
    return
  end
  local all = vim.pack.get(nil, { info = false })
  table.sort(all, function(a, b)
    return a.spec.name < b.spec.name
  end)
  pack_ui.items = vim.tbl_filter(function(item)
    return pack_ui.filter == "" or item.spec.name:lower():find(pack_ui.filter:lower(), 1, true) ~= nil
  end, all)

  local lines = {
    " vim.pack                                      " .. #pack_ui.items .. "/" .. #all .. " plugins",
    " [/] filter  [u] update  [U] update all  [d] delete  [l] load  [r] refresh  [q] close",
    "",
  }
  for _, item in ipairs(pack_ui.items) do
    local state = item.active and "●" or "○"
    local rev = item.rev and item.rev:sub(1, 8) or "--------"
    lines[#lines + 1] = string.format(" %s %-28s %s", state, item.spec.name, rev)
  end
  pack_ui.detail_start = #lines + 2
  lines[#lines + 1] = ""
  vim.bo[pack_ui.buf].modifiable = true
  vim.api.nvim_buf_set_lines(pack_ui.buf, 0, -1, false, lines)
  vim.bo[pack_ui.buf].modifiable = false
  pack_ui_details()
end

local function pack_ui_refresh()
  local old = pack_ui_current()
  pack_ui_render()
  if not pack_ui.win or not vim.api.nvim_win_is_valid(pack_ui.win) then
    return
  end
  local row = 4
  for i, item in ipairs(pack_ui.items) do
    if old and item.spec.name == old.spec.name then
      row = i + 3
      break
    end
  end
  vim.api.nvim_win_set_cursor(pack_ui.win, { math.min(row, math.max(4, vim.api.nvim_buf_line_count(pack_ui.buf))), 0 })
end

local function pack_ui_update(names)
  pack_ui_close()
  vim.pack.update(names)
end

local function pack_ui_open()
  if pack_ui.win and vim.api.nvim_win_is_valid(pack_ui.win) then
    pack_ui_close()
    return
  end
  pack_ui.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[pack_ui.buf].buftype = "nofile"
  vim.bo[pack_ui.buf].bufhidden = "wipe"
  vim.bo[pack_ui.buf].swapfile = false
  vim.bo[pack_ui.buf].filetype = "vim-pack"
  vim.cmd("tabnew")
  pack_ui.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(pack_ui.win, pack_ui.buf)
  vim.wo[pack_ui.win].number = false
  vim.wo[pack_ui.win].relativenumber = false
  vim.wo[pack_ui.win].signcolumn = "no"
  vim.wo[pack_ui.win].cursorline = true
  vim.wo[pack_ui.win].wrap = false

  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = pack_ui.buf, silent = true, desc = desc })
  end
  map("q", pack_ui_close, "Close package UI")
  map("<Esc>", pack_ui_close, "Close package UI")
  map("r", pack_ui_refresh, "Refresh package list")
  map("u", function()
    local item = pack_ui_current()
    if item then
      pack_ui_update({ item.spec.name })
    end
  end, "Update selected plugin")
  map("U", function()
    pack_ui_update()
  end, "Update all plugins")
  map("d", function()
    local item = pack_ui_current()
    if item and not item.active then
      pack_ui_close()
      vim.pack.del({ item.spec.name })
    elseif item then
      vim.notify("Unload the plugin before deleting it", vim.log.levels.WARN)
    end
  end, "Delete inactive plugin")
  map("l", function()
    local item = pack_ui_current()
    if item and not item.active then
      vim.cmd.packadd(item.spec.name)
      pack_ui_refresh()
    end
  end, "Load selected plugin")
  map("/", function()
    vim.ui.input({ prompt = "Filter plugins: ", default = pack_ui.filter }, function(value)
      if value == nil then
        return
      end
      pack_ui.filter = value
      pack_ui_refresh()
    end)
  end, "Filter plugins")
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = pack_ui.buf,
    callback = pack_ui_details,
  })
  pack_ui_render()
  vim.api.nvim_win_set_cursor(pack_ui.win, { 4, 0 })
end

command("Pack", pack_ui_open, { desc = "Open vim.pack manager" })
vim.keymap.set("n", "<leader>pp", pack_ui_open, { desc = "Package Manager" })

-- Small, always-visible UI plugins are cheap enough to initialize synchronously.
-- nvim-treesitter's current main branch must be loaded during startup; it
-- supplies parser/query files used by Neovim's built-in Tree-sitter features.
setup_once("nvim-treesitter", function()
  require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })
  -- require("nvim-treesitter").install()
end)

load("catppuccin")
require("catppuccin").setup({
  flavour = "macchiato",
  integrations = {
    blink_cmp = true,
    gitsigns = true,
    treesitter = true,
    notify = true,
    mini = true,
    mason = true,
    noice = true,
    which_key = true,
    bufferline = true,
    lsp_trouble = true,
    fzf = true,
  },
})
vim.cmd.colorscheme("catppuccin-macchiato")

load("mini.icons")
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

load("lualine.nvim")
require("lualine").setup({ options = { theme = "catppuccin-macchiato" } })

load("bufferline.nvim")
require("bufferline").setup()

-- Defer the rest until the first UI cycle. This keeps startup responsive while
-- retaining the full feature set once the editor is ready.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      load("which-key.nvim")
      require("which-key").setup()
      load("gitsigns.nvim")
      require("gitsigns").setup()
    end)
  end,
})

local function setup_fzf()
  setup_once("fzf-lua", function()
    require("fzf-lua").setup({})
  end)
  vim.keymap.set("n", "<leader><space>", "<Cmd>FzfLua files<CR>", { desc = "Smart Find" })
  vim.keymap.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
  vim.keymap.set("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
  vim.keymap.set("n", "<leader>e", "<Cmd>FzfLua files cwd=~/.dotfiles/.config/nvim<CR>", { desc = "Config Files" })
end

local function setup_tree()
  setup_once("nvim-tree.lua", function()
    require("nvim-tree").setup({
      view = { width = 36, preserve_window_proportions = true },
      update_focused_file = { enable = true, update_root = true },
      renderer = { highlight_git = true, highlight_opened_files = "name" },
      actions = { open_file = { resize_window = true } },
    })
  end)
end

vim.keymap.set("n", "<leader>ff", function()
  setup_fzf()
  vim.cmd.FzfLua("files")
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function()
  setup_fzf()
  vim.cmd.FzfLua("live_grep")
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fe", function()
  setup_tree()
  vim.cmd.NvimTreeToggle()
end, { desc = "File Explorer" })

command("StartupTime", function()
  load("vim-startuptime")
  vim.cmd.StartupTime()
end)
vim.keymap.set("n", "<leader>ut", "<Cmd>StartupTime<CR>", { desc = "StartupTime" })

-- Feature setup is grouped by the event that needs it, similar to LazyVim's
-- event/ft/cmd specs. Each group is initialized at most once by Lua's module cache.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    setup_once("mini.comment", function()
      require("mini.comment").setup()
    end)
    setup_once("mini.surround", function()
      require("mini.surround").setup()
    end)
    setup_once("mini.hipatterns", function()
      require("mini.hipatterns").setup()
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "go",
    "gomod",
    "python",
    "java",
    "yaml",
    "json",
    "markdown",
    "markdown_inline",
    "dockerfile",
    "sql",
    "php",
    "typescript",
    "javascript",
    "tsx",
    "html",
    "css",
  },
  callback = function()
    setup_once("nvim-treesitter-context", function()
      require("treesitter-context").setup({})
    end)
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if vim.g.autoformat == false then
      return
    end
    setup_once("conform.nvim", function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          go = { "gofmt" },
        },
        formatters = { prettier = { prepend_args = { "--single-quote", "--jsx-single-quote" } } },
      })
    end)
    require("conform").format({ bufnr = args.buf, async = false, lsp_fallback = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    setup_once("nvim-lint", function()
      local lint = require("lint")
      lint.linters_by_ft = { fish = { "fish" }, python = { "ruff" }, go = { "golangcilint" } }
    end)
    require("lint").try_lint()
  end,
})

local function setup_sessions()
  setup_once("mini.sessions", function()
    require("mini.sessions").setup({ autoread = true, autowrite = true })
  end)
end

vim.keymap.set("n", "<leader>qs", function()
  setup_sessions()
  MiniSessions.write()
end, { desc = "Session Save" })
vim.keymap.set("n", "<leader>ql", function()
  setup_sessions()
  MiniSessions.select()
end, { desc = "Session Load" })

-- Completion and snippets are only useful once insert mode is entered. In
-- particular, avoid parsing the VS Code snippet collection on every launch.
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    setup_once("blink.cmp", function()
      load("blink.lib")
      load("LuaSnip")
      load("friendly-snippets")
      require("blink.cmp").setup({
        keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
        snippets = { preset = "luasnip" },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
      })
    end)
  end,
})

-- LSP discovery is needed for real files, not dashboards and empty buffers.
-- Schedule it once so the file can paint before Mason scans its registry.
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    vim.schedule(function()
      setup_once("mason.nvim", function()
        require("mason").setup()
      end)
      setup_once("mason-lspconfig.nvim", function()
        load("nvim-lspconfig")
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "gopls",
            "pyright",
            "jdtls",
            "yamlls",
            "jsonls",
            "dockerls",
            "bashls",
            "ansiblels",
            "sqlls",
            "phpactor",
          },
          automatic_enable = true,
        })
      end)
      setup_once("arborist.nvim", function()
        require("arborist").setup()
      end)
    end)
  end,
})

command("Trouble", function(args)
  setup_once("trouble.nvim", function()
    require("trouble").setup({})
  end)
  vim.cmd.Trouble(args.args)
end, { nargs = "*", desc = "Open diagnostics" })

local function setup_messages()
  setup_once("nvim-notify", function()
    local notify = require("notify")
    notify.setup({ background_colour = "#000000", render = "compact", timeout = 3000 })
    vim.notify = notify
  end)
  setup_once("noice.nvim", function()
    load("nui.nvim")
    load("plenary.nvim")
    require("noice").setup({
      lsp = { progress = { enabled = true }, hover = { enabled = true }, signature = { enabled = true } },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    })
  end)
end

vim.api.nvim_create_autocmd("CmdlineEnter", { once = true, callback = setup_messages })
vim.keymap.set("n", "<leader>nn", function()
  setup_messages()
  vim.cmd.Notifications()
end, { desc = "Notifications" })
vim.keymap.set("n", "<leader>sn", function()
  setup_messages()
  require("noice").cmd("history")
end, { desc = "Noice History" })
vim.keymap.set("n", "<leader>sd", function()
  setup_messages()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss Messages" })

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      setup_sessions()
      setup_once("mini.starter", function()
        local starter = require("mini.starter")
        starter.setup({
          header = "vim.pack + mini.starter",
          items = {
            starter.sections.builtin_actions(),
            starter.sections.recent_files(8, false),
            starter.sections.sessions(5, true),
          },
          footer = "f: find, e: new, q: quit",
        })
      end)
      if vim.bo.filetype == "" then
        require("mini.starter").open()
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_browser = ""
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_theme = "dark"
    load("markdown-preview.nvim")
    vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", { buffer = true, desc = "Markdown Preview" })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if data.file == "" or vim.fn.isdirectory(data.file) == 0 then
      return
    end
    setup_tree()
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})
