-- TODO BREAK UP INTO MULTIPLE FILES

M = {}

-- TREESITTER UTILITIES
function M.buffer_has_parser(bufnr)
  local parsers = require("nvim-treesitter.parsers")
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local lang = parsers.get_buf_lang(bufnr)
  return parsers.has_parser(lang)
end

vim.api.nvim_create_user_command("CheckLeanSemanticTokens", function()
  local clients = vim.lsp.get_clients()
  for _, client in pairs(clients) do
    if client.name == "leanls" then
      local capabilities = client.server_capabilities
      if capabilities == nil then
        print("No Lean LSP capabilities found.")
        return
      end
      print("Lean LSP semantic tokens capability:")
      for cap in pairs(capabilities) do
        print(cap)
      end
    end
  end
end, {})

-- TODO pimp out later
M.vks = vim.keymap.set

function M.print_table(v, indent)
  indent = indent or 0
  local pad = string.rep("  ", indent)
  if type(v) == "table" then
    for k, val in pairs(v) do
      local formatting = pad .. tostring(k) .. ": "
      if type(val) == "table" then
        print(formatting)
        M.print_table(val, indent + 1)
      else
        print(formatting .. tostring(val))
      end
    end
  elseif type(v) == "function" then
    print(pad .. tostring(v))
  else
    print(pad .. tostring(v))
  end
end

return M
