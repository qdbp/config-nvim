-- GENERAL SETTINGS
-- colors
vim.opt.termguicolors = true
-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- sessions (as recommended by autosession)
vim.opt.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- generic
vim.opt.cursorline = true
vim.opt.modeline = true
vim.opt.formatoptions = "cqjtr"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.matchpairs:append("<:>")
vim.opt.fillchars:append({ diff = "░" })
vim.opt.showtabline = 0

-- columns
vim.opt.foldcolumn = "1"
vim.opt.signcolumn = "yes:2"

-- undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"

-- diable old file browser
-- TODO move to nvim-tree load?
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- diff
vim.g.diffopt = table.concat({
  "internal",
  "indent-heuristic",
  "algorithm:patience",
  "linematch:60",
  "inline:word",
  "context:3",
  "filler",
  "closeoff",
}, ",")

-- indent guides
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_start_level = 3

-- clipboard magic to work with ssh
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = { -- Remove paste functionality if terminal doesn't support it
    ["+"] = function() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end,
    ["*"] = function() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end,
  },
}
