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

map("n", "<Leader>gd", vim.lsp.buf.definition)
map("n", "<Leader>gD", vim.lsp.buf.declaration)
map("n", "<Leader>gr", vim.lsp.buf.references)
map("n", "<Leader>gi", vim.lsp.buf.implementation)
map("n", "<leader>tr", "<Cmd>Trouble diagnostics toggle<CR>")
map("n", "K", vim.lsp.buf.hover)
map("n", "<C-p>", vim.diagnostic.goto_prev)
map("n", "<C-n>", vim.diagnostic.goto_next)
