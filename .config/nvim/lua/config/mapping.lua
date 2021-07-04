
--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

--Remap escape to leave terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], {noremap = true})

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])


vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", {noremap = true, silent = true})
map("n", "<silent> gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<silent> gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "<silent> gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<silent> gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<silent> K", ":Lspsaga hover_doc<CR>")
map("n", "<silent> <C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<silent> <C-n>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "<silent> <C-p>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

map("i", "<silent><expr> <C-Space>", "compe#complete()")
map("i", "<silent><expr> <CR>", "compe#confirm('<CR>')")
map("i", "<silent><expr> <C-e>", "compe#close('<C-e>')")
map("i", "<silent><expr> <C-f>", "compe#scroll({ 'delta': +4 })")
map("i", "<silent><expr> <C-d>", "compe#scroll({ 'delta': -4 })")

map("n", "<silent><leader>ca", ":Lspsaga code_action<CR>")
map("v", "<silent><leader>ca", ":<C-U>Lspsaga range_code_action<CR>")
map("n", "<silent><leader>gr", ":Lspsaga rename<CR>")
map("n", "<silent><leader>gh", ":Lspsaga lsp_finder<CR>")
map("n", "<silent><leader>K", ":Lspsaga hover_doc<CR>")

map("n", "<silent> <C-f>", "<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>")
map("n", "<silent> <C-b>", "<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>")