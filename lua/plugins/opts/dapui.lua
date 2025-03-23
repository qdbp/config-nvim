M = {}

M.opts = {
  layouts = {
    {
      elements = {
        -- Elements can be strings or tables with id and size keys
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- Width of the panel
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
}

return M
