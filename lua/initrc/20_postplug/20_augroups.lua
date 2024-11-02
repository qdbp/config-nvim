-- generic autogroup helpers
-- enable access/write highlight
-- TODO move to lsp specific secion? lsp is big

-- LSP
-- 1: highlight write/read references
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

-- FOLDING
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

-- DIFFVIEW
-- fix the folds for diffs, etc
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory" },
  callback = function() vim.wo.foldmethod = "diff" end,
})

-- TREE:
-- open automatically:
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
  vim.cmd("wincmd p")
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
