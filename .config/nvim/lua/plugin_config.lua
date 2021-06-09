require('globals.lua')
require('nvimTree.lua')
require('lspConfig.lua')
require('luaLine.lua')
require('whichKey.lua')
require('gitsigns').setup()
require('colorizer').setup()
require('lspsaga').init_lsp_saga()
require('treesitter.lua')
require('compe.lua')
require('utils.lua')

-- LSP
require('lsp')
require('lsp.angular-ls')
require('lsp.bash-ls')
require('lsp.clangd')
require('lsp.css-ls')
require('lsp.dart-ls')
require('lsp.docker-ls')
require('lsp.efm-general-ls')
require('lsp.elm-ls')
require('lsp.emmet-ls')
require('lsp.graphql-ls')
require('lsp.go-ls')
require('lsp.html-ls')
require('lsp.json-ls')
require('lsp.js-ts-ls')
require('lsp.kotlin-ls')
require('lsp.latex-ls')
require('lsp.lua-ls')
require('lsp.php-ls')
require('lsp.python-ls')
require('lsp.ruby-ls')
require('lsp.rust-ls')
require('lsp.svelte-ls')
require('lsp.terraform-ls')
-- require('lsp.tailwindcss-ls')
require('lsp.vim-ls')
require('lsp.vue-ls')
require('lsp.yaml-ls')
require('lsp.elixir-ls')

--vim.lsp.callbacks['textDocument/publishDiagnostics'] = nil

vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
map('n', '<silent> gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<silent> gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<silent> gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<silent> gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<silent> K', ':Lspsaga hover_doc<CR>')
map('n', '<silent> <C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<silent> <C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<silent> <C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

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

vim.g['deoplete#enable_at_startup'] = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_status_lines = 1
vim.g.nord_uniform_diff_background = 1
vim.g.nord_cursor_line_number_background = 1
