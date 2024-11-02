U = require("util")
local vks = U.vks

-- TODO this is some scuffed garbage atm, fix up
local function exe_python()
  -- local file = vim.fn.shellescape(vim.fn.expand("%"), 1)
  vim.fn.system("python " .. vim.fn.expand("%"))
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    -- allow easy file execution with F5
    vks("n", "<leader>F", "F'if<ESC>``", { buffer = true })
    vks("n", "<F5>", exe_python, { buffer = true })
  end,
})

-- disable diagnostics for common library paths
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*/site-packages/*", "*/venv/*" },
  callback = function(args) vim.diagnostic.enable(false, { bufnr = args.buf }) end,
})
