-- static swaps, moves, etc.
local U = require("util")
require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  ignore_install = { "ipkg" },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  incremental_selection = {
    enable = true,
    -- TODO find decent ones
    keymaps = {
      init_selection = "<C-s>",
      node_incremental = "<C-s>",
      node_decremental = "<C-d>",
      scope_incremental = "<BS>",
    },
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
        ["<leader>sc"] = "@class.outer",
        ["<leader>sm"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
        ["<leader>sC"] = "@class.outer",
        ["<leader>sM"] = "@function.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer", -- around function
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]b"] = "@block.outer",
        ["]l"] = "@loop.outer",
        ["]a"] = "@call.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
    },
  },
})

--- SMART SWAP
local query = vim.treesitter.query
local swap_mod = require("nvim-treesitter.textobjects.swap")
local ts_utils = require("nvim-treesitter.ts_utils")

local targets_by_prio = {
  "parameter.inner",
  "argument.inner", -- some grammars use this instead
  "assignment.inner",
  "attribute.inner",
  "call.outer",
  -- might be useful in some languages?
  -- "block.outer",
  "function.outer",
  "class.outer",
}

---@return { row: number, col: number }
local function get_cursor_coords()
  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  -- convert to 0-based
  cursor_row = cursor_row - 1
  cursor_col = cursor_col -- don't ask, columns are already 0-based?
  return { row = cursor_row, col = cursor_col }
end

local function pformat_node(node)
  local start_row, start_col, end_row, end_col = node:range()
  return string.format("%s[%d:%d - %d:%d]", node:type(), start_row, start_col, end_row, end_col)
end

--- checks if the cursor position is within the bounds of the node
---@param node any
---@param coords { row: number, col: number }
---@return boolean
local function node_subtends_coords(node, coords)
  local start_row, start_col, end_row, end_col = node:range()
  -- if we're anywhere betwen the second and penultimate row, inclusive, we're in the node
  -- irrespective of the column. because we only have a single range we decide for convenience
  -- that if the cursor is far off the line in the middle of the node's rows that it
  if coords.row > start_row and coords.row < end_row then
    return true
  elseif coords.row == start_row then
    -- if we're on the first row, we must be in the node's column range
    return coords.col >= start_col
  -- rows are inclusive...
  elseif coords.row == end_row then
    -- if we're on the last row, we must be in the node's column range
    -- ... columns are exclusive
    return coords.col < end_col
  end
  -- otherwise, we're not in the node
  return false
end

local function do_swap(dir)
  -- query the current ts node and find the smallest enclosing target.
  -- do not try to swap targets "larger" than that one.
  local node = ts_utils.get_node_at_cursor()

  if not node then return end
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  if not lang then return end
  local q = query.get(lang, "textobjects")
  if not q then return end

  -- TODO this +1 is mysterious but things clearly break without it (i.e. no results
  -- when cursor is on type_identified of impl block. I think iter_captures assumes the
  -- end row is exclusive.
  local start_row, _, end_row, _ = node:range()
  local best_ix = nil
  local cursor_coords = get_cursor_coords()

  vim.notify(
    "Swapping "
      .. dir
      .. " from node: "
      .. pformat_node(node)
      .. " cursor is at "
      .. cursor_coords.row
      .. ":"
      .. cursor_coords.col
      .. "start row: "
      .. start_row
      .. " end row: "
      .. end_row,
    vim.log.levels.DEBUG
  )
  -- to swap we require that the cursor actually falls within the node's range
  -- and furthermore that we are on the first row of the node (to avoid spooky
  -- swap action at a distance from deep within e.g. a function body)
  for id, n in q:iter_captures(node:root(), 0, start_row, end_row + 1) do
    if not node_subtends_coords(n, cursor_coords) then
      -- not worth logging
    elseif cursor_coords.row ~= n:start() then
      vim.notify(
        "ignoring node: "
          .. q.captures[id]
          .. " at "
          .. pformat_node(n)
          .. " because it does not start on the cursor row"
      )
    else
      local ix = U.indexof(targets_by_prio, q.captures[id])
      if (ix ~= nil) and (best_ix == nil or ix < best_ix) then
        vim.notify(
          "updated target: " .. q.captures[id] .. " at " .. pformat_node(n),
          vim.log.levels.DEBUG
        )
        best_ix = ix
      end
    end
  end

  if best_ix == nil then
    vim.notify("No swappable node under cursor", vim.log.levels.INFO)
    return
  end

  local target = targets_by_prio[best_ix]
  local fn_move = dir == "next" and swap_mod.swap_next or swap_mod.swap_previous
  local ok, moves = pcall(fn_move, target)
  if not ok then vim.notify("Error getting swap moves: " .. moves, vim.log.levels.ERROR) end
end

vim.keymap.set("n", "<A-Left>", function() do_swap("prev") end, { desc = "TS-swap node left/up" })

vim.keymap.set(
  "n",
  "<A-Right>",
  function() do_swap("next") end,
  { desc = "TS-swap node right/down" }
)
