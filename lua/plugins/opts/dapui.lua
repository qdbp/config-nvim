----------------------------------------------------------------------
--  DAP-UI LAYOUT: THREE ZONES (L | R | ⌄)                           --
----------------------------------------------------------------------
return function()
  local dap, dapui = require("dap"), require("dapui")

  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "➜" },
    controls = {
      enabled = true,
      element = "repl", -- keep the transport buttons next to the REPL
      icons = {
        pause = "",
        play = "",
        step_into = "⏬",
        step_over = "⏩",
        step_out = "⏫",
        step_back = "⏪",
        run_last = "🔁",
        terminate = "⏹️",
      },
    },
    layouts = {
      ------------------------------------------------------------------
      -- LEFT  – thin column just for breakpoints (fast eye-scan)      --
      ------------------------------------------------------------------
      {
        position = "left",
        size = 25, -- columns
        elements = { "breakpoints" },
      },
      ------------------------------------------------------------------
      -- RIGHT – everything stateful about your process                --
      ------------------------------------------------------------------
      {
        position = "right",
        size = 50, -- columns
        elements = {
          { id = "scopes", size = 0.50 }, -- locals/variables first
          { id = "stacks", size = 0.25 }, -- call stack
          { id = "watches", size = 0.25 }, -- custom watches (⇧ +i to add)
        },
      },
      ------------------------------------------------------------------
      -- BOTTOM – interactive consoles                                 --
      ------------------------------------------------------------------
      {
        position = "bottom",
        size = 15, -- lines
        elements = { "repl", "console" },
      },
    },
    floating = { border = "single" }, -- nicer hover pop-ups
  })

  ----------------------------------------------------------------------
  --  HOUSEKEEPING WHEN THE UI OPENS                                   --
  ----------------------------------------------------------------------
  local function close_tree_and_extra_vsplits()
    -- 1. Hide nvim-tree if it’s visible
    local ok, api = pcall(require, "nvim-tree.api")
    if ok and api.tree.is_visible() then api.tree.close() end

    -- 2. Close every *vertical* split except the leftmost
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local leftmost = nil
    local left_edge = math.huge
    for _, win in ipairs(wins) do
      local _, col = unpack(vim.api.nvim_win_get_position(win))
      if col < left_edge then
        left_edge, leftmost = col, win
      end
    end
    for _, win in ipairs(wins) do
      if win ~= leftmost and vim.api.nvim_win_get_config(win).relative == "" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end

  ----------------------------------------------------------------------
  --  AUTOMATE THE WHOLE THING                                         --
  ----------------------------------------------------------------------
  dap.listeners.after.event_initialized["dapui_layout"] = function()
    close_tree_and_extra_vsplits()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_layout"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_layout"] = function() dapui.close() end

  ----------------------------------------------------------------------
  --  INLINE VARIABLE GHOST TEXT                                       --
  ----------------------------------------------------------------------
  require("nvim-dap-virtual-text").setup({
    commented = true, -- “--  a = 42”
  })
end
