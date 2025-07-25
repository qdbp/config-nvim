---@module 'plugins.opts.telescope'
local opts = {
  defaults = {
    file_ignore_patterns = {
      -- python
      "site%-packages/.*%.py$",
      ".*/?build/.*%.py$",
    },
  },
  extensions = {
    fzf_native = { -- ← matches the extension’s module name
      fuzzy = true,
      override_generic_sorter = true, -- lets the extension patch in
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        width = 0.4,
        height = 0.2,
        results_height = 8,
        border = true,
      }),
    },
  },
}

return function()
  local t = require("telescope")
  t.setup(opts)
  t.load_extension("fzf")
  t.load_extension("ui-select")
end
