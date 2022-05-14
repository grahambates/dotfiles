local dap = require('dap')

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

dap.adapters.asm68k = {
  type = 'executable',
  command = home .. '/uae-dap/cli.js',
  -- command = 'node',
  -- args = { '--inspect', home .. '/uae-dap/out/debugAdapter.js' },
  -- command = 'uae-dap',
  options = { initialize_timeout_sec = 10 },
}

dap.configurations.asm68k = {
  {
    type = 'asm68k',
    request = 'launch',
    program = '${workspaceFolder}/uae/dh0/gencop',
    cwd = '${workspaceFolder}',
    -- custom settings:
    stopOnEntry = false,
    serverName = "localhost",
    serverPort = 6860,
    trace = false,
    startEmulator = true,
    emulator = home .. "/amiga/bin/fs-uae",
    emulatorWorkingDir = home .."/amiga/bin",
    emulatorOptions = {
      "--hard_drive_0=${workspaceFolder}/uae/dh0",
      "--remote_debugger=200",
      "--use_remote_debugger=true",
      "--automatic_input_grab=0"
    },
  }
}

-- dap.set_log_level('DEBUG')
