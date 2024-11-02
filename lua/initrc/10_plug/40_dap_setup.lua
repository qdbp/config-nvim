-- python
local py_dap = require("dap-python")
py_dap.setup("python")
py_dap.test_runner = "pytest"

require("neotest").setup({
  adapters = { require("neotest-python")({ dap = { justMyCode = false } }) },
})
