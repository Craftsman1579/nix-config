-- Base Neovim configuration converted from nixvim opts/globals
local M = {}

-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Options
local o = vim.o
local wo = vim.wo

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false
o.clipboard = 'unnamedplus'
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 10
o.hlsearch = true
o.termguicolors = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Auto commands
local yank_group = vim.api.nvim_create_augroup('highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  callback = function() vim.highlight.on_yank() end,
})

return M
