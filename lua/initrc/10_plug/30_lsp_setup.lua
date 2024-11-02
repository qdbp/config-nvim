-- preliminaries
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- individual lsps
local lsp = require("lspconfig")

-- JSON, YAML
lsp.yamlls.setup({})
lsp.jsonls.setup({})

-- HELM
lsp.helm_ls.setup({
  capabilities = capabilities,
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
})

-- BASH
lsp.bashls.setup({
  capabilities = capabilities,
})

-- LEAN
lsp.leanls.setup({
  capabilities = capabilities,
})

-- PYTHON
lsp.basedpyright.setup({
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
      },
    },
  },
})

-- TODO may be better to call ruff through pylsp? check if there are conflicts here
lsp.ruff.setup({})
lsp.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false, maxLineLength = 1000000 },
        flake8 = { enabled = false, maxLineLength = 1000000, select = {} },
        pycodestyle = { enabled = false, maxLineLength = 100000, select = {} },
        yapf = { enabled = false, maxLineLength = 100000 },
        pyflakes = { enabled = false, maxLineLength = 100000, select = {} },
        mccabe = { enabled = false },
        rope = { enabled = true },
        preload = { enabled = false },
      },
    },
  },
})

-- C/C++
lsp.clangd.setup({})

-- LUA
lsp.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 10000,
      },
      format = {
        enable = true,
      },
    },
  },
})

-- XML
lsp.lemminx.setup({})
