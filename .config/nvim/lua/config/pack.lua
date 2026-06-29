vim.pack.add({
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
  { name = "nvim-treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
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
  { name = "mini.animate", src = "https://github.com/echasnovski/mini.animate.git" },
  { name = "mini.hipatterns", src = "https://github.com/echasnovski/mini.hipatterns.git" },
  { name = "dial.nvim", src = "https://github.com/monaqa/dial.nvim.git" },
  { name = "yanky.nvim", src = "https://github.com/gbprod/yanky.nvim.git" },
  { name = "unified.nvim", src = "https://github.com/axkirillov/unified.nvim.git" },
}, { load = true, confirm = false })

pcall(function()
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
end)

pcall(vim.cmd.colorscheme, "catppuccin-macchiato")

pcall(function()
  require("which-key").setup()
end)

pcall(function()
  require("lualine").setup({ options = { theme = "catppuccin-macchiato" } })
end)

pcall(function()
  require("bufferline").setup()
end)

pcall(function()
  require("nvim-tree").setup({
    view = {
      width = 36,
      preserve_window_proportions = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "name",
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
  })

  vim.keymap.set("n", "<leader>fe", "<Cmd>NvimTreeToggle<CR>", { desc = "File Explorer" })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("user_open_nvim_tree_on_dir", { clear = true }),
    callback = function(data)
      local path = data.file
      if path == "" then
        return
      end
      local stat = vim.uv.fs_stat(path)
      if not stat or stat.type ~= "directory" then
        return
      end
      vim.cmd.cd(path)
      require("nvim-tree.api").tree.open()
    end,
  })
end)

pcall(function()
  require("gitsigns").setup()
end)

pcall(function()
  require("fzf-lua").setup({})

  vim.keymap.set("n", "<leader><space>", "<Cmd>FzfLua files<CR>", { desc = "Smart Find" })
  vim.keymap.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "Grep" })
  vim.keymap.set("n", "<leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Buffers" })
  vim.keymap.set("n", "<leader>e", "<Cmd>FzfLua files cwd=~/.dotfiles/.config/nvim<CR>", { desc = "Config Files" })
end)

vim.keymap.set("n", "<leader>ut", "<Cmd>StartupTime<CR>", { desc = "StartupTime" })

pcall(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
end)

pcall(function()
  local notify = require("notify")
  vim.notify = notify
  notify.setup({
    background_colour = "#000000",
    render = "compact",
    timeout = 3000,
  })

  vim.keymap.set("n", "<leader>nn", "<Cmd>Notifications<CR>", { desc = "Notifications" })
end)

pcall(function()
  require("mini.sessions").setup({
    autoread = true,
    autowrite = true,
  })

  vim.keymap.set("n", "<leader>qs", function()
    MiniSessions.write()
  end, { desc = "Session Save" })
  vim.keymap.set("n", "<leader>ql", function()
    MiniSessions.select()
  end, { desc = "Session Load" })
end)

pcall(function()
  local starter = require("mini.starter")
  starter.setup({
    header = "vim.pack + mini.starter",
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(8, false),
      starter.sections.recent_files(8, true),
      starter.sections.sessions(5, true),
    },
    footer = "f: find, e: new, q: quit",
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("user_dashboard", { clear = true }),
    callback = function()
      if vim.fn.argc() == 0 and vim.bo.filetype == "" then
        MiniStarter.open()
      end
    end,
  })
end)

pcall(function()
  require("noice").setup({
    lsp = {
      progress = { enabled = true },
      hover = { enabled = true },
      signature = { enabled = true },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
  })

  vim.keymap.set("n", "<leader>sn", function()
    require("noice").cmd("history")
  end, { desc = "Noice History" })
  vim.keymap.set("n", "<leader>sd", function()
    require("noice").cmd("dismiss")
  end, { desc = "Dismiss Messages" })
end)

pcall(function()
  vim.g.mkdp_auto_start = 0
  vim.g.mkdp_auto_close = 1
  vim.g.mkdp_refresh_slow = 0
  vim.g.mkdp_browser = ""
  vim.g.mkdp_echo_preview_url = 1
  vim.g.mkdp_markdown_css = ""
  vim.g.mkdp_theme = "dark"

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_markdown_preview_cmd", { clear = true }),
    pattern = { "markdown" },
    callback = function()
      vim.cmd([[silent! call mkdp#util#install()]])
      vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", {
        buffer = true,
        desc = "Markdown Preview",
      })
    end,
  })
end)

pcall(function()
  require("mini.comment").setup()
  require("mini.surround").setup()
  require("mini.animate").setup()
  require("mini.hipatterns").setup()
end)

pcall(function()
  require("trouble").setup({})
end)

pcall(function()
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  })
end)

pcall(function()
  require("mason").setup()
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

pcall(function()
  local langs = {
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
  }

  local ts = require("nvim-treesitter")
  ts.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })
  ts.install(langs)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_treesitter_start", { clear = true }),
    pattern = langs,
    callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  require("treesitter-context").setup({})
end)

pcall(function()
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
    formatters = {
      prettier = {
        prepend_args = { "--single-quote", "--jsx-single-quote" },
      },
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("user_format_on_save", { clear = true }),
    callback = function(args)
      if vim.g.autoformat == false then
        return
      end
      require("conform").format({ bufnr = args.buf, async = false, lsp_fallback = true })
    end,
  })
end)

pcall(function()
  local lint = require("lint")
  lint.linters_by_ft = {
    fish = { "fish" },
    python = { "ruff" },
    go = { "golangcilint" },
  }

  local lint_group = vim.api.nvim_create_augroup("user_lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    group = lint_group,
    callback = function()
      lint.try_lint()
    end,
  })
end)
