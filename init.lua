-- PRE-PLUGIN CONFIG

-- SET COLORS
vim.o.termguicolors = true

-- set leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- set tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- diable old file browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- PLUGINS
require('config.lazy')
require('config.treesitter')
require('config.lsp_setup')
require('config.dap_setup')
set_hl = require('config.salmon')
set_hl()


-- POST-PLUGIN CONFIG
-- GENERIC KEYBINDS
-- enforced efficiency
vim.keymap.set('', '<Up>', '<NOP>', { silent = true })
vim.keymap.set('', '<Down>', '<NOP>', { silent = true })
vim.keymap.set('', '<Left>', '<NOP>', { silent = true })
vim.keymap.set('', '<Right>', '<NOP>', { silent = true })
vim.keymap.set('', ':', '<NOP>', {})
vim.keymap.set('', ';', ':', {})
vim.keymap.set({ 'n' }, 'q', '<C-w>', {})
vim.keymap.set('n', '<S-J>', '<C-O>', { desc = 'Jump back' })
vim.keymap.set('n', '<S-K>', '<C-I>', { desc = 'Jump forward' })

-- LSP BINDINGS
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local vks = vim.keymap.set
        local map = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        map('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        map('n', '<Leader><C-b>', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        map('n', '<F18>', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        map('n', 'gd', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Displays a function's signature information
        map('n', '<M-p>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        map({ 'n', 'v' }, '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        -- bufmap('x', '<M-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Show diagnostics in a floating window
        map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        -- Move to the previous diagnostic
        map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        -- Move to the next diagnostic
        map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        -- format
        vks('n', '<space>lf', function() vim.lsp.buf.format() end, { noremap = true })
    end
})
-- enable access/write highlight
local grp = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return
        end
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
    end,
    group = grp,
})

-- GIT BINDINGS
-- blame
vim.keymap.set({ 'n' }, '<F60>', '<cmd>BlameToggle<cr>')
-- git signs
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
-- easy search and replace
vim.keymap.set('n', '<Leader>s', ':%s//g<Left><Left>', { noremap = true })

-- buffer switching
vim.keymap.set('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-q>', '<C-l>', { noremap = true, silent = true })

-- debugging
if require('dap') then
    local d = require('dap')
    local w = require('dap.ui.widgets')
    vim.keymap.set('n', '<A-b>', d.toggle_breakpoint)
    vim.keymap.set('n', '<A-l>', d.continue)
    vim.keymap.set('n', '<A-j>', d.step_into)
    vim.keymap.set('n', '<A-k>', d.step_out)
    vim.keymap.set({ 'n', 'v' }, '<A-h>', function() w.centered_float(w.hover) end)
    vim.keymap.set({ 'n', 'v' }, '<A-s>', function() w.centered_float(w.scopes) end)
    vim.keymap.set({ 'n', 'v' }, '<A-f>', function() w.centered_float(w.frames) end)
end

-- PLUGIN KEYBINDS
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fhl', builtin.highlights, {})
vim.keymap.set('n', '<leader>fkm', builtin.keymaps, {})

-- VIM SETTINGS
vim.o.modeline = true
vim.o.formatoptions = 'cqjt'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true

-- folding
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
})
-- TODO upgrade to a more general session/workspace management flow
vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = "remember_folds",
    pattern = "*.*",
    command = "mkview"
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "remember_folds",
    pattern = "*.*",
    command = "silent! loadview"
})

vim.o.mouse = 'a'
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.hidden = true
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'

-- columns
vim.o.foldcolumn = '2'
vim.diagnostic.config({
    update_in_insert = false,
})
vim.o.signcolumn = 'yes:2'

-- statusline
local function custom_statusline_color()
    local mode = vim.api.nvim_get_mode().mode
    if vim.bo.modified then
        -- Set modified color
        return '%#StatusLineModified#'
    elseif mode == 'n' then
        -- Set normal mode color
        return '%#StatusLineNormal#'
    else
        -- Set other mode color
        return '%#StatusLineOther#'
    end
end
local statusline = {
    ' %t',
    '%r',
    '%m',
    '%=',
    '%{&filetype}',
    ' %2p%%',
    ' %3l:%-2c ',
    '%*',
}

vim.o.statusline = custom_statusline_color() .. table.concat(statusline, '')

-- GENERIC HELPERS
-- PLUGINS - GLOBAL

-- navigation
-- TREE
-- open automatically:
local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
    vim.cmd("wincmd p")
end
vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { callback = open_nvim_tree }
)

-- make directories into folds... it's too logical!
local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'zo', api.node.open.edit, opts('Open selected directory'))
    -- this is just a toggle, but let's not abuse muscle memory
    vim.keymap.set('n', 'zc', api.node.open.edit, opts('Close selected directory'))
    vim.keymap.set('n', 'zO', api.tree.expand_all, opts('Open selected directory recursively'))
    vim.keymap.set('n', 'zC', api.tree.collapse_all, opts('Close selected directory recursively'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    on_attach = my_on_attach,
}

-- indent guides
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_start_level = 3

-- ECHODOC
vim.o.cmdheight = 2
vim.g.echodoc_enable_at_startup = 1

-- FILETYPE SETTINGS

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "<F5>", function()
            local file = vim.fn.shellescape(vim.fn.expand("%"), 1)
            vim.cmd("exec '!python " .. file .. "'")
        end, { buffer = true })
    end,
})
