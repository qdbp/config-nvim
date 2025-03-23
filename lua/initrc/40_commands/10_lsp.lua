-- Store disabled clients and their original handlers
local disabled_clients = {}

local function refresh_diagnostics()
  -- Clear existing diagnostics
  -- vim.diagnostic.reset()

  -- Request fresh diagnostics for all buffers in workspace
  -- for _, client in ipairs(vim.lsp.get_clients()) do
  --   if client.supports_method("textDocument/diagnostic") then
  --     require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
  --   end
  -- end
end

vim.api.nvim_create_user_command("LspToggleClient", function(opts)
  local pattern = opts.args
  if pattern == "" then
    print("Usage: LspToggleClient <pattern>")
    return
  end
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name:match(pattern) then
      local client_id = client.id
      if disabled_clients[client_id] then
        -- Re-enable diagnostics
        client.handlers["textDocument/publishDiagnostics"] = disabled_clients[client_id]
        disabled_clients[client_id] = nil
        print(string.format("Enabled diagnostics for %s", client.name))
      else
        -- Disable diagnostics
        disabled_clients[client_id] = client.handlers["textDocument/publishDiagnostics"]
        client.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          -- Still process the result but clear diagnostics
          if disabled_clients[client_id] then
            result.diagnostics = {}
            return disabled_clients[client_id](err, result, ctx, config)
          end
        end
        print(string.format("Disabled diagnostics for %s", client.name))
      end
    end
  end
  refresh_diagnostics()
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_map(function(client) return client.name end, vim.lsp.get_clients())
  end,
})
