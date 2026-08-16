-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Ansible's language server only attaches to `yaml.ansible`. Detect YAML files
-- inside projects with standard Ansible root markers, plus conventional role
-- and playbook directory layouts.
vim.filetype.add {
  pattern = {
    ['.*%.ya?ml'] = function(path, bufnr)
      local normalized = path:gsub('\\', '/')
      local is_ansible_path = normalized:match('/playbooks/')
        or normalized:match('/roles/[^/]+/tasks/')
        or normalized:match('/roles/[^/]+/handlers/')
        or normalized:match('/roles/[^/]+/defaults/')
        or normalized:match('/roles/[^/]+/vars/')
        or normalized:match('/roles/[^/]+/meta/')

      if is_ansible_path or vim.fs.root(bufnr, { 'ansible.cfg', '.ansible-lint' }) then return 'yaml.ansible' end
    end,
  },
}
