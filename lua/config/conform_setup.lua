if require("conform") then
  local c = require("conform")
  c.setup({
    formatters_by_ft = {
      lua = { "stylua" },
    },
    format_on_save = {
      lsp_fallback = false,
      async = false,
      timeout_ms = 500,
    },
  })
end
