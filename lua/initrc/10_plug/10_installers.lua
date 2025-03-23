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

ml.setup_handlers({
  function(server_name)
    if server_name ~= "jdtls" then
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
  end,
})

-- other tools
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua",
  },
})
