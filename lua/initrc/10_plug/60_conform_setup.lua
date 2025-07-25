local conform = require("conform")
if not conform then
  vim.notify("conform not found, skipping setup", vim.log.levels.WARN)
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- java = { "mvn_format" },
    rust = { "rustfmt" },
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
    -- mvn_format = {
    --   command = "nmxmvn",
    --   args = { "formatter:format" },
    -- },
    {
      command = "rustfmt",
      args = { "--emit", "stdout" }, -- stdin→stdout = fast diff
      cwd = require("conform.util").root_file({ "Cargo.toml", "rustfmt.toml", ".git" }),
    },
  },
})
