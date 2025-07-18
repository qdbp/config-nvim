-- language servers
require("mason").setup({})
local ml = require("mason-lspconfig")
ml.setup({
  automatic_enable = true,
  ensure_installed = {
    -- bash
    "bashls",
    -- C/C++
    "clangd",
    "jdtls",
    "lemminx",
    -- lua
    "lua_ls",
    -- python
    -- "basedpyright",
    "pylsp",
    "ruff",
    "ty",
    -- markups, etc.
    "helm_ls",
    "jsonls",
    "yamlls",
  },
})

-- dap magic
require("mason-nvim-dap").setup({
  ensure_installed = {
    "codelldb",
    "python",
  },
  automatic_setup = true,
})

-- other tools
require("mason-tool-installer").setup({ ensure_installed = {
  "codelldb",
  "stylua",
} })
