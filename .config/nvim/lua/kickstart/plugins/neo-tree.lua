-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '<leader>d', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer', silent = true })

require('neo-tree').setup {
  filesystem = {
    filtered_items = {
       visible = true
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}
