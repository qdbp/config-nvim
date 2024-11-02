-- GENERAL SETTINGS
-- colors
vim.o.termguicolors = true
-- leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- diable old file browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- sessions (as recommended by autosession)
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- generic
-- TODO check if any of these are still useful
vim.o.cursorline = true
vim.o.modeline = true
vim.o.formatoptions = "cqjtr"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.matchpairs = vim.o.matchpairs .. ",<:>"
-- columns
vim.o.foldcolumn = "2"
vim.o.signcolumn = "yes:2"
-- indent guides
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_start_level = 3
