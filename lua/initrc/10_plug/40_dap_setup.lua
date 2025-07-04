-- python
local py_dap = require("dap-python")
py_dap.setup("python")
py_dap.test_runner = "pytest"

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      args = { "-n", "0", "--log-level", "DEBUG", "--quiet", "--capture", "no", "--tb", "no" },
      dap = {
        justMyCode = false,
        -- console = "integratedTerminal",
      },
    }),
    require("neotest-java"),
  },
})
