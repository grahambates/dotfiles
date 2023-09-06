local dap = require('dap')
local dapui = require('dapui')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    sourceMaps = true,
  },
}

dap.configurations.typescript = {
  {
    name = 'Test',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/jest',
    args = { "--no-cache", "--runInBand" },
    cwd = vim.fn.getcwd(),
    -- sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    sourceMaps = true,
  },
}

local home = os.getenv('HOME')

-- dap.defaults.fallback.focus_terminal = true
-- dap.defaults.fallback.auto_continue_if_many_stopped = false

dap.adapters.asm68k = {
  type = 'executable',
  -- command = 'uae-dap',
  command = 'node',
  args = { '--inspect', home .. '/projects/uae-dap/out/src/debugAdapter.js' },
  options = { initialize_timeout_sec = 20 },
}

dap.configurations.asm68k = {
  {
    type = 'asm68k',
    request = 'launch',
    program = '${workspaceFolder}/out/a.hunk-debug.exe',
    remoteProgram = "SYS:a.exe",
    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,
    trace = false,
    stopOnEntry = false,
    emulatorArgs = { "--hard_drive_0=${workspaceFolder}/out", "--stdout" },
    vasm = {
      args = {
        '-I' .. home .. '/amiga/ndk',
        '-I' .. home .. '/amiga/libraries',
      }
    }
  }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/Users/batesgw1/homebrew/Cellar/llvm/14.0.6_1/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- dap.set_log_level('DEBUG')

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
