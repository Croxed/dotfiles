local ok, _ = pcall(vim.cmd, "packadd packer.nvim")

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local _, packer = pcall(require, "packer")
if fn.empty(fn.glob(install_path)) > 0 then
  print('Cloning packer into ' .. install_path)
	vim.fn.delete(install_path, "rf")
  execute('!git clone --depth 20 https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
	_, packer = pcall(require, "packer")
end

return packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	git = {
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
})
