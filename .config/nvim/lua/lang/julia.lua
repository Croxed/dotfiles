local M = {}

M.config = function()
  O.lang.julia = {
    lsp = {
      path = CONFIG_PATH .. "/lua/lsp/julia/run.jl",
    },
  }
end

M.format = function()
  -- todo: implement formatters (if applicable)
  return "no formatters configured!"
end

M.lint = function()
  -- todo: implement linters (if applicable)
  return "no linters configured!"
end

M.lsp = function()
  if require("utils.lua").check_lsp_client_active "julials" then
    return
  end
  -- Add the following lines to a new julia file, e.g. install.jl
  -- using Pkg
  -- Pkg.instantiate()
  -- Run the file you created.
  -- julia install.jl
  -- Julia language server will now be installed on your system.

  local cmd = {
    "julia",
    "--startup-file=no",
    "--history-file=no",
    -- vim.fn.expand "~/.config/nvim/lua/lsp/julia/run.jl",
    O.lang.julia.lsp.path,
  }
  require("lspconfig").julials.setup {
    cmd = cmd,
    on_new_config = function(new_config, _)
      new_config.cmd = cmd
    end,
    filetypes = { "julia" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
