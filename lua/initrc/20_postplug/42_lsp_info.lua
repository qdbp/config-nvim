-- LSP informational fixes and tweaks
local mk_grp = vim.api.nvim_create_augroup
local mk_cmd = vim.api.nvim_create_autocmd

-- 1: auto highlight write/read references
local group = vim.api.nvim_create_augroup("lsp_augrp", {})
mk_cmd("LspAttach", {
  group = group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    if not client then return end
    if client.server_capabilities.documentHighlightProvider then
      local grp = vim.api.nvim_create_augroup("lsp_document_highlight" .. bufnr, { clear = true })
      mk_cmd("CursorMoved", {
        buffer = bufnr,
        group = grp,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end,
      })
    end
    -- 2: subgroup, code lens refresh
    if client.server_capabilities.codeLensProvider then
      local grp1 = mk_grp("lsp_codelens_refresh_" .. bufnr, { clear = true })
      mk_cmd(
        { "BufEnter", "CursorHold", "InsertLeave" },
        { buffer = bufnr, group = grp1, callback = vim.lsp.codelens.refresh }
      )
    end
  end,
})
