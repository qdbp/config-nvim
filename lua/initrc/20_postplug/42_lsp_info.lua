-- LSP informational fixes and tweaks

-- 1: auto highlight write/read references
local group = vim.api.nvim_create_augroup("lsp_augrp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
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

-- 2: auto signature popup
-- _G.signature_window_state = {
--   opened = false,
--   forced = false,
-- }
--
-- -- Custom signature handler to prevent flickering
-- local function signature_handler(handler)
--   return function(...)
--     return handler(...)
--
--     -- if _G.signature_window_state.forced and _G.signature_window_state.opened then
--     --   _G.signature_window_state.forced = false
--     --   return handler(...)
--     -- end
--     --
--     -- if _G.signature_window_state.opened then return end
--     --
--     -- local fbuf, fwin = handler(...)
--     -- _G.signature_window_state.opened = true
--     -- vim.api.nvim_create_autocmd("WinClosed", {
--     --   pattern = tostring(fwin),
--     --   callback = function() _G.signature_window_state.opened = false end,
--     --   once = true,
--     -- })
--     -- return fbuf, fwin
--   end
-- end
--
-- -- Replace the default handler
-- vim.lsp.handlers["textDocument/signatureHelp"] =
--   vim.lsp.with(signature_handler(vim.lsp.handlers.signature_help), {
--     border = "shadow",
--     focus = false,
--     focusable = false,
--     close_events = { "BufHidden", "InsertLeave" },
--   })
--
-- -- Set up autocommands for automatic triggering
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   pattern = "*",
--   callback = function() vim.lsp.buf.signature_help() end,
--   desc = "Show signature help on cursor hold in insert mode",
-- })
--
-- -- Optional keymaps for manual triggering
-- vim.keymap.set({ "i", "n" }, "<C-k>", function()
--   _G.signature_window_state.forced = true
--   vim.lsp.buf.signature_help()
-- end, { silent = true, desc = "Toggle signature help" })
