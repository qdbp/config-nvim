U = require("util")
local vks = U.vks

-- FILE EXECUTION
local last_args = nil
local execute_buf_name = "ExecutePython"

local function execute_python_file(args)
  -- aborted!
  if args == nil then return end

  -- Get current buffer's file path
  local file = vim.api.nvim_buf_get_name(0)

  -- If args provided, store them. Otherwise use last args or empty string
  if args then last_args = args end
  local run_args = last_args or ""

  -- TODO this wipeout isn't working--- but it's kind of good without it?
  vim.cmd("silent! bwipeout " .. execute_buf_name)

  -- Create a new window split
  vim.api.nvim_command("botright vsplit")
  vim.api.nvim_win_set_width(0, math.floor(vim.opt.columns * 0.4))

  -- Create a new terminal buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, execute_buf_name)
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_win_set_buf(0, buf)

  -- Open terminal and execute Python file with args
  vim.fn.termopen("python3 " .. vim.fn.shellescape(file) .. " " .. run_args)

  -- Return to the main window
  vim.api.nvim_command("wincmd h")
end

local function prompt_args_and_run()
  vim.ui.input(
    { prompt = "Arguments: ", default = "" },
    function(input) execute_python_file(input) end
  )
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vks("n", "<leader>F", "F'if<ESC>``", { buffer = true })
    -- allow easy file execution with F5
    vks("n", "<F53>", prompt_args_and_run, { buffer = true })
    vks("n", "<F5>", execute_python_file, { buffer = true })
  end,
})

-- disable diagnostics for common library paths
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*/site-packages/*", "*/venv/*", "*/src/build/*" },
  callback = function(args) vim.diagnostic.enable(false, { bufnr = args.buf }) end,
})
