local cmd = vim.cmd
local map = vim.keymap.set

map("n", "<leader>n", "<Cmd>set nu!<CR>")
map("i", "jk", "<esc>")
map("c", "jk", "<C-C>")
map("n", ";", ":")

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "<c-k>", "<C-w>k")
map("n", "<c-j>", "<C-w>j")
map("n", "<c-h>", "<C-w>h")
map("n", "<c-l>", "<C-w>l")

cmd([[autocmd BufWritePre * %s/\s\+$//e]])
cmd([[autocmd BufWritePre * %s/\n\+\%$//e]])

map("x", "<leader>p", [['_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>")
map("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>")

map("n", "<Leader>gd", function()
  vim.lsp.buf.definition()
end)
map("n", "<Leader>gD", function()
  vim.lsp.buf.declaration()
end)
map("n", "<Leader>gr", function()
  vim.lsp.buf.references()
end)
map("n", "<Leader>gi", function()
  vim.lsp.buf.implementation()
end)
map("n", "<leader>tr", "<Cmd>Trouble diagnostics toggle<CR>")
map("n", "K", function()
  vim.lsp.buf.hover()
end)
map("n", "<C-p>", function()
  vim.diagnostic.goto_prev()
end)
map("n", "<C-n>", function()
  vim.diagnostic.goto_next()
end)
