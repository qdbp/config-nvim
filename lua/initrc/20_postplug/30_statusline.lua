-- TODO this is too basic. need efficient way to make background different if file not written etc
-- don't really want to use lualine?
local statusline = {
  "%F",
  "%r",
  "%m",
  "%=",
  "%{&filetype}",
  " %2p%%",
  " %3l:%-2c ",
  "%*",
}

local function custom_statusline_color()
  local mode = vim.api.nvim_get_mode().mode
  if vim.bo.modified then
    -- Set modified color
    return "%#StatusLineModified#"
  elseif mode == "n" then
    -- Set normal mode color
    return "%#StatusLineNormal#"
  else
    -- Set other mode color
    return "%#StatusLineOther#"
  end
end

vim.o.statusline = custom_statusline_color() .. table.concat(statusline, "")
