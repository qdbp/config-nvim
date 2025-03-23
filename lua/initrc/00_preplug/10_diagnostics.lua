-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  -- Force single column
  severity_sort = true,
})

-- TODO
-- -- TWEAK: show at most one sign per line
-- -- Get reference to the original signs handler
-- local orig_signs_handler = vim.diagnostic.handlers.signs
--
-- -- Create a custom namespace
-- local ns = vim.api.nvim_create_namespace("max_one_sign")
--
-- -- Override the built-in signs handler
-- vim.diagnostic.handlers.signs = {
--   show = function(_, bufnr, _, opts)
--     -- Get all diagnostics from the buffer
--     local diagnostics = vim.diagnostic.get(bufnr)
--
--     -- Track highest severity diagnostic per line
--     local max_severity_per_line = {}
--     for _, d in pairs(diagnostics) do
--       local m = max_severity_per_line[d.lnum]
--       if not m or d.severity < m.severity then max_severity_per_line[d.lnum] = d end
--     end
--
--     -- Convert the severity map to an array of diagnostics
--     local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
--
--     -- Show signs using original handler with filtered diagnostics
--     orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
--   end,
--
--   hide = function(_, bufnr) orig_signs_handler.hide(ns, bufnr) end,
-- }
