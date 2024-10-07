-- language servers
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "basedpyright",
    "lemminx",
    "lua_ls",
    "ruff",
    "clangd",
    "pylsp",
    "helm_ls",
    "yamlls",
  },
})

-- other tools
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
  },
})
