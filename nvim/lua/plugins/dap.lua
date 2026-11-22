return {
  {
    "mfussenegger/nvim-dap",
    optional = true, -- only applies if dap.core already added this plugin
    config = function()
      local dap = require("dap")

      -- dap.adapters.puae = {
      --   type = "server",
      --   host = "127.0.0.1",
      --   port = 4711,
      -- }
      dap.adapters.puae = {
        type = "executable",
        command = "node",
        args = { "/Users/BatesGW1/projects/vscode-puae-debugger/out/standalone.js", "--stdio" },
      }
    end,
  },
}
