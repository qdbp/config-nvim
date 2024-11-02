-- language servers
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "basedpyright",
    "clangd",
    "helm_ls",
    "jsonls",
    "lemminx",
    "lua_ls",
    "pylsp",
    "ruff",
    "yamlls",
  },
})

-- other tools
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
  },
})
