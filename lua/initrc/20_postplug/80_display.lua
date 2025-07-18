-- prettify the LSP “hover” window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded", -- try "single", "double", "shadow", or even a custom border table
  max_width = 80, -- wrap at 80 chars
  max_height = 40, -- don’t let it grow taller than 40 lines
  winblend = 5, -- gentle transparency
  focusable = false, -- don’t steal focus
})
