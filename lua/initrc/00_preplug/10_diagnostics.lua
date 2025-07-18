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
  float = {
    border = "single", -- same border styles apply here
    source = "always", -- show “[lsp]” or “[eslint]” etc.
    prefix = "", -- no leading “- “ on each line
    winblend = 5, -- match your hover blend
    close_events = { "CursorMoved", "InsertEnter", "FocusLost" },
  },
})
