-- language servers
require("mason").setup({})
local ml = require("mason-lspconfig")
ml.setup({
  ensure_installed = {
    "bashls",
    "basedpyright",
    "clangd",
    "helm_ls",
    "jdtls",
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
