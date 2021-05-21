
require('nvimTree.lua')
require('lspConfig.lua')
require('luaLine.lua')
-- require('gitsigns').setup()
require('colorizer').setup()
require('lspsaga').init_lsp_saga()
require('treesitter.lua')
require('compe.lua')
require('utils.lua')

vim.fn['neomake#configure#automake']('nrwi', 500)
--vim.lsp.callbacks['textDocument/publishDiagnostics'] = nil

map('n', '<silent> gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<silent> gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<silent> gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<silent> gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<silent> K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<silent> <C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<silent> <C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<silent> <C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

--[[ 
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
 ]]

g['deoplete#enable_at_startup'] = 1
g['nord_italic'] = 1
g['nord_italic_comments'] = 1
g['nord_uniform_status_lines'] = 1
g['nord_uniform_diff_background'] = 1
g['nord_cursor_line_number_background'] = 1
