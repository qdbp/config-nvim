-- the config is modular, we just load all the files we need here
local function load_initrc()
  local initrc_dir = vim.fn.expand(vim.fn.stdpath("config") .. "/lua/initrc")
  local files = vim.fn.glob(initrc_dir .. "**/*.lua", false, true)
  table.sort(files) -- alphanumeric order
  for _, file in ipairs(files) do
    local module_path = file
      :gsub(".lua$", "") -- remove .lua extension
      :gsub("^.+/lua/", "") -- remove path prefix
      :gsub("/", ".") -- convert path to module format
    require(module_path)
  end
end
load_initrc()
