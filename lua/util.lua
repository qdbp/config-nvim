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

-- TODO fix
-- function M.get_overlapping_capabilities()
--   local clients = vim.lsp.get_clients({ bufnr = 0 })
--   if #clients < 2 then return {} end
--
--   -- Track capabilities and their count
--   local capability_count = {}
--
--   -- Count capabilities from each client
--   for _, client in ipairs(clients) do
--     for capability, value in pairs(client.server_capabilities) do
--       if value == true then
--         capability_count[capability] = (capability_count[capability] or 0) + 1
--       end
--     end
--   end
--
--   -- Filter for capabilities with count >= 2
--   local overlapping = {}
--   for capability, count in pairs(capability_count) do
--     if count >= 2 then table.insert(overlapping, capability) end
--   end
--
--   return overlapping
-- end

-- TODO pimp out later
M.vks = vim.keymap.set

return M
