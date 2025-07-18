local dap = require("dap")
if not dap then return end

local neotest = require("neotest")
if not neotest then return end

-- python
local py_dap = require("dap-python")
py_dap.setup("python")
py_dap.test_runner = "pytest"

neotest.setup({
  adapters = {
    require("neotest-python")({
      args = { "-n", "0", "--log-level", "DEBUG", "--quiet", "--capture", "no", "--tb", "no" },
      dap = {
        justMyCode = false,
        -- console = "integratedTerminal",
      },
    }),
    require("neotest-java"),
    require("rustaceanvim.neotest")({
      dap = { adapter = "codelldb" },
      args = { "--no-capture" }, -- see stdout like pytest -s
    }),
  },
})

-- rust
dap.configurations.rust = {
  {
    name = "Debug current test",
    type = "codelldb",
    request = "launch",
    program = function()
      -- rustaceanvim helper (or custom shell one-liner) returns the test binary
      return require("rustaceanvim.config").get_cargo_test_executable()
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = false,
  },
}
