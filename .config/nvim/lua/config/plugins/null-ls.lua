local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.setup(options)
  local nls = require("null-ls")
  local formatting = nls.builtins.formatting
  nls.setup({
    debounce = 150,
    save_after_format = false,
    sources = {
      formatting.prettier, formatting.black, formatting.gofmt, formatting.shfmt,
      formatting.clang_format, formatting.cmake_format, formatting.dart_format,
      formatting.lua_format.with({
        extra_args = {
          '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
          '--break-after-table-lb', '--indent-width=2'
        }
      }), formatting.isort, formatting.codespell.with({filetypes = {'markdown'}})
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
