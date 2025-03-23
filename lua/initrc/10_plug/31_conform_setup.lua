if require("conform") then
  local c = require("conform")
  c.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      java = { "mvn_format" },
    },
    format_on_save = function(bufnr)
      -- no format on save for java files
      if vim.tbl_contains({ "java" }, vim.bo[bufnr].filetype) then return end
      return {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      }
    end,
    formatters = {
      mvn_format = {
        command = "nmxmvn",
        args = { "formatter:format" },
      },
    },
  })
end
