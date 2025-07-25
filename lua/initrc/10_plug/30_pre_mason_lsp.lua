-- individual lsps
local lsp = require("lspconfig")
lsp.util.default_config.capabilities = vim.tbl_deep_extend(
  "force",
  lsp.util.default_config.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

--====================
--== LANGUAGE SERVERS
--====================

--\______
-- PYTHON
--/‾‾‾‾‾‾

vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        pycodestyle = { enabled = false },
        yapf = { enabled = false },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        rope = { enabled = true },
        preload = { enabled = false },
        mypy = { enabled = false },
      },
    },
  },
})

vim.lsp.config("ruff", {
  settings = {
    ruff = {
      enable_formatting = true,
      enable_diagnostics = true,
    },
  },
})

--\___
-- LUA
--/‾‾‾

vim.lsp.config("lua_ls", {
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

--\_____
-- HELM (vomit)
--/‾‾‾‾‾‾

vim.lsp.config("helm_ls", {
  settings = {
    helm = {
      schemaDownload = { enable = true },
      lint = {
        enable = true,
      },
      format = {
        enable = true,
      },
    },
  },
})
