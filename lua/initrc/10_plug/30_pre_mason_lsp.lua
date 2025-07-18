-- individual lsps
local lsp = require("lspconfig")
lsp.util.default_config.capabilities = vim.tbl_deep_extend(
  "force",
  lsp.util.default_config.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

--==============================
--== LANGUAGE SERVERS
--==============================

-- TODO may be better to call ruff through pylsp? check if there are conflicts here
vim.lsp.config("pylsp", {
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
        mypy = { enabled = false },
      },
    },
  },
})
-- lsp.ruff.setup({})
-- lsp.ty.setup({})

-- C/C++
-- lsp.clangd.setup({})

-- LUA
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

-- XML
-- lsp.lemminx.setup({})
