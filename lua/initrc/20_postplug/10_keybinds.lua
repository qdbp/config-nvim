-- plugin-specific keymaps
-- TODO consider breaking up further? kind of nice seeing it all in one file though
U = require("util")
local vks = U.vks

-- LSP BINDINGS
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    -- Displays hover information about the symbol under the cursor
    vks("n", "gk", vim.lsp.buf.hover)
    vks("n", "gk", vim.lsp.buf.hover)
    vks({ "n", "i" }, "<F1>", vim.lsp.buf.signature_help)

    -- Shift+<F6>
    vks("n", "<F18>", vim.lsp.buf.rename)

    -- Lists all the implementations for the symbol under the cursor
    vks("n", "gi", vim.lsp.buf.implementation)
    vks("n", "gd", vim.lsp.buf.definition)
    vks("n", "gD", vim.lsp.buf.type_definition)
    vks("n", "gr", vim.lsp.buf.references)

    -- Displays a function's signature information
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
      timeout_ms = 1000,
    })
  end
  vks({ "n", "v" }, "<Leader>lf", fmt, { desc = "Format file or range" })
end

-- DIFF
if require("diffview") then
  local function toggle_diffview()
    if next(require("diffview.lib").views) == nil then
      vim.cmd("DiffviewOpen")
    else
      vim.cmd("DiffviewClose")
    end
  end
  vks("n", "<M-d>", toggle_diffview, { desc = "Toggle diffview" })
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
  -- TODO consider just using resession.nvim
  local pb = require("persistent-breakpoints.api")
  if not pb then pb = d end
  -- TODO conditional breakpoints and logpoints??
  vks("n", "<A-b>", pb.toggle_breakpoint)
  vks(
    "n",
    "<A-B>",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
  )
  vks("n", "<A-c>", d.run_to_cursor)
  vks("n", "<A-l>", d.continue)
  vks("n", "<A-j>", d.step_into)
  vks("n", "<A-J>", d.down)
  vks("n", "<A-k>", d.step_out)
  vks("n", "<A-K>", d.up)
  vks("n", "<A-o>", d.step_over)
  vks("n", "<A-h>", d.step_back)
  vks("n", "<A-r>", function()
    if d.session() then
      d.restart()
    else
      d.run_last()
    end
  end)
  vks("n", "<A-Esc>", d.terminate)
  vks({ "n", "v" }, "<A-s>", function() w.centered_float(w.scopes) end)
  vks({ "n", "v" }, "<A-f>", function() w.centered_float(w.frames) end)
end

if require("dapui") then
  local dap, u = require("dap"), require("dapui")
  u.setup()
  dap.listeners.before.attach.dapui_config = function() u.open() end
  dap.listeners.before.launch.dapui_config = function() u.open() end
  dap.listeners.before.event_terminated.dapui_config = function() u.close() end
  dap.listeners.before.event_exited.dapui_config = function() u.close() end
  -- ui-specific keybinds
  vks("v", "<A-e>", u.eval, { desc = "Evaluate visual expression" })
end

-- TEST RUNNER BINDINGS
if require("neotest") then
  local nt = require("neotest")
  vks("n", "<leader>tr", nt.run.run, { desc = "Run test" })
  vks("n", "<leader>td", function() nt.run.run({ strategy = "dap" }) end, { desc = "Debug test" })
  vks("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end, { desc = "Test file" })
  vks("n", "<leader>tp", nt.output_panel.toggle, { desc = "toggle test output panel" })
  vks("n", "<leader>to", nt.output.open, { desc = "show test output" })
  vks("n", "<leader>ts", nt.summary.toggle, { desc = "toggle test summary panel" })
  vks("n", "<leader>ta", function() nt.run.run("test/") end, { desc = "Run all tests" })
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
vks("n", "<leader>9", "<cmd>AerialToggle right<cr>", { desc = "Toggle aerial" })

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
