-- GENERAL SETTINGS
-- colors
vim.o.termguicolors = true
-- leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- tabs
-- TODO seems to glitch out with just vim.g, just spam it and hope it works!
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
vim.o.cursorline = true
vim.o.modeline = true
vim.o.formatoptions = "cqjt"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true
vim.o.matchpairs = vim.o.matchpairs .. ",<:>"
-- columns
vim.o.foldcolumn = "2"
vim.o.signcolumn = "yes:2"
vim.diagnostic.config({ update_in_insert = false })
-- indent guides
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_start_level = 3

-- NON-PLUGIN KEYBINDS
local vks = vim.keymap.set
-- enforced efficiency
vks("", "<Up>", "<NOP>", { silent = true })
vks("", "<Down>", "<NOP>", { silent = true })
vks("", "<Left>", "<NOP>", { silent = true })
vks("", "<Right>", "<NOP>", { silent = true })
vks("", ":", "<NOP>", {})
vks("", ";", ":", {})
vks("n", "<S-I>", "<C-O>", { desc = "Jump back" })
vks("n", "<S-K>", "<C-I>", { desc = "Jump forward" })
-- easy search and replace
vks("n", "<Leader>s", ":%s///g<Left><Left><Left>")
-- buffer switching
-- vks("n", "<C-n>", ":bnext<CR>", { silent = true })
-- vks("n", "<C-p>", ":bprevious<CR>", { silent = true })
-- use q instead of C-w to navigate windows much more ergonomically
-- TODO better macro keybinding
vks({ "n" }, "w", "<C-w>", {})
-- TODO remove when salmon is packaged
-- COLORS
-- local salmon = require("config.salmon")
-- salmon.set_signs()
-- salmon.set_highlights()

----------
-- PLUGINS
----------
require("config.lazy")
require("config.installers")
require("config.treesitter")
require("config.conform_setup")
require("config.lsp_setup")
require("config.dap_setup")
--- utils
U = require("util")

-- LSP BINDINGS
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    -- Displays hover information about the symbol under the cursor
    vks("n", "gk", vim.lsp.buf.hover)

    -- Shift+<F6>
    vks("n", "<F18>", vim.lsp.buf.rename)

    -- Lists all the implementations for the symbol under the cursor
    vks("n", "gi", vim.lsp.buf.implementation)
    vks("n", "gd", vim.lsp.buf.definition)
    vks("n", "gD", vim.lsp.buf.type_definition)
    vks("n", "gr", vim.lsp.buf.references)

    -- Displays a function's signature information
    vks("n", "<M-p>", vim.lsp.buf.signature_help)
    vks({ "n", "v" }, "<M-CR>", vim.lsp.buf.code_action)

    -- Show diagnostics in a floating window
    vks("n", "gl", vim.diagnostic.open_float)
    -- Move to the previous diagnostic
    vks("n", "[d", vim.diagnostic.goto_prev)
    -- Move to the next diagnostic
    vks("n", "]d", vim.diagnostic.goto_next)
  end,
})
-- LINTER + FORMATTER BINDINGS
if require("conform") then
  local conform = require("conform")
  local function fmt()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end
  vks({ "n", "v" }, "<Leader>lf", fmt, { desc = "Format file or range" })
end

-- GIT BINDINGS
-- neogit
if require("neogit") then
  local neogit = require("neogit")
  vks("n", "<leader>G", neogit.open)
end
-- blame
vks({ "n" }, "<F60>", "<cmd>BlameToggle<cr>", { desc = "Toggle git blame" })
-- gitsigns
if require("gitsigns") then
  local g = require("gitsigns")
  vks("n", "<leader>hs", g.stage_hunk, { desc = "Stage hunk" })
  vks("n", "<leader>hr", g.reset_hunk, { desc = "Reset hunk" })
  vks(
    "v",
    "<leader>hs",
    function() g.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
    { desc = "Stage selected hunk" }
  )
  vks(
    "v",
    "<leader>hr",
    function() g.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
    { desc = "Reset selected hunk" }
  )
  vks("n", "<leader>hS", g.stage_buffer, { desc = "Stage buffer" })
  vks("n", "<leader>hu", g.undo_stage_hunk, { desc = "Undo stage hunk" })
  vks("n", "<leader>hR", g.reset_buffer, { desc = "Reset buffer" })
  vks("n", "<leader>hp", g.preview_hunk, { desc = "Preview hunk" })
  vks("n", "<leader>hd", g.diffthis, { desc = "Diff this" })
  vks("n", "<leader>hb", g.blame_line, { desc = "Blame line" })
  vks("n", "<leader>hB", function() g.blame_line({ full = true }) end, { desc = "Blame line" })
  vks("n", "<leader>hD", function() g.diffthis("~") end, { desc = "Diff this (~)" })
  vks("n", "<leader>td", g.toggle_deleted, { desc = "Toggle deleted" })
end
-- DEBUGGER BINDINGS
if require("dap") then
  local d = require("dap")
  local w = require("dap.ui.widgets")
  vks("n", "<A-b>", d.toggle_breakpoint)
  vks("n", "<A-l>", d.continue)
  vks("n", "<A-j>", d.step_into)
  vks("n", "<A-o>", d.step_over)
  vks("n", "<A-k>", d.step_out)
  vks("n", "<A-h>", d.step_back)
  -- vks({ 'n', 'v' }, '<A-h>',  w.preview)
  -- vks({ "n", "v" }, "<A-h>", w.hover)
  vks({ "n", "v" }, "<A-s>", function() w.centered_float(w.scopes) end)
  vks({ "n", "v" }, "<A-f>", function() w.centered_float(w.frames) end)
end
if require("dapui") then
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup()
  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
  dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
end

-- OTHER PLUGIN KEYBINDS
-- spectre
if require("spectre") then
  local spectre = require("spectre")
  vks("n", "<leader>S", spectre.toggle)
  vks(
    "n",
    "<leader>sw",
    function() spectre.open_visual({ select_word = true }) end,
    { desc = "Search current word" }
  )
  vks("v", "<leader>sw", spectre.open_visual, { desc = "Search current word" })
end

-- telescope
local builtin = require("telescope.builtin")
vks("n", "<leader>ff", builtin.find_files, {})
vks("n", "<leader>fg", builtin.live_grep, {})
vks("n", "<leader>fb", builtin.buffers, {})
vks("n", "<leader>fh", builtin.help_tags, {})
vks("n", "<leader>fhl", builtin.highlights, {})
vks("n", "<leader>fkm", builtin.keymaps, {})

-- aerial
vks("n", "<leader>0", "<cmd>AerialNavToggle<cr>", { desc = "Toggle aerial" })

-- nvim tree
-- make directories into folds... it's too logical!
if require("nvim-tree.api") then
  local api = require("nvim-tree.api")
  -- general keymaps
  vks("n", "<leader>T", api.tree.toggle, { desc = "Toggle tree" })
  vks("n", "<F49>", api.tree.toggle, { desc = "Find current file in tree" })
  vks(
    "n",
    "<F50>",
    function() api.tree.find_file(false, true, true) end,
    { desc = "Find current file in tree" }
  )

  -- on attach keymaps
  local function nvim_tree_keymap_onattach(bufnr)
    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- custom mappings
    vks("n", "<Leader>q", "q", opts("Close the tree"))
    vks("n", "zo", api.node.open.edit, opts("Open selected directory"))
    -- this is just a toggle, but let's not abuse muscle memory
    vks("n", "zc", api.node.open.edit, opts("Close selected directory"))
    vks("n", "zO", api.tree.expand_all, opts("Open selected directory recursively"))
    vks("n", "zC", api.tree.collapse_all, opts("Close selected directory recursively"))
  end
  -- pass to setup along with your other options
  require("nvim-tree").setup({ on_attach = nvim_tree_keymap_onattach })
end

-- AUTOGROUPS
-- enable access/write highlight
group = vim.api.nvim_create_augroup("lsp_augrp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    if not client then return end
    if client.server_capabilities.documentHighlightProvider then
      local grp = vim.api.nvim_create_augroup("lsp_document_highlight" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        group = grp,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
      })
    end
  end,
})

-- autofold
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(data)
    local name = vim.api.nvim_buf_get_name(data.buf)
    if name:match("diffview") or name:match("gitsigns") then
      vim.wo.foldmethod = "diff"
    elseif U.buffer_has_parser(data.buf) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.wo.foldmethod = "indent"
    end
  end,
})
-- fix the folds for diffs, etc
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  callback = function() vim.wo.foldmethod = "diff" end,
})

-- STATUS LINE
local function custom_statusline_color()
  local mode = vim.api.nvim_get_mode().mode
  if vim.bo.modified then
    -- Set modified color
    return "%#StatusLineModified#"
  elseif mode == "n" then
    -- Set normal mode color
    return "%#StatusLineNormal#"
  else
    -- Set other mode color
    return "%#StatusLineOther#"
  end
end
local statusline = {
  "%F",
  "%r",
  "%m",
  "%=",
  "%{&filetype}",
  " %2p%%",
  " %3l:%-2c ",
  "%*",
}

vim.o.statusline = custom_statusline_color() .. table.concat(statusline, "")

-- GENERIC HELPERS
-- PLUGINS - GLOBAL

-- navigation
-- TREE
-- open automatically:
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
  vim.cmd("wincmd p")
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- FILETYPE SETTINGS
-- lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- python
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    -- allow easy file execution with F5
    vks("n", "<F5>", function()
      local file = vim.fn.shellescape(vim.fn.expand("%"), 1)
      vim.cmd("exec '!python " .. file .. "'")
    end, { buffer = true })
  end,
})
-- disable diagnostics for common library paths
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*/site-packages/*", "*/venv/*" },
  callback = function(args) vim.diagnostic.enable(false, { bufnr = args.buf }) end,
})
-- helm
-- do not detect helm-like yamls as yaml:
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.yaml"] = "helm",
  },
})
