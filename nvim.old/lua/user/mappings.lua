local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opts = { noremap = true, silent = true }

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("i", "<C-h>", "<C-w>h", opts)
map("i", "<C-j>", "<C-w>j", opts)
map("i", "<C-k>", "<C-w>k", opts)
map("i", "<C-l>", "<C-w>l", opts)

map('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- More convenient mappings for standard commands
map('n', 'H', '^', opts)
map('n', 'Q', '@@', opts)

-- Delete without clobbering unnamed register
map('n', 's', '"_d', opts)
map('n', 'ss', '"_dd', opts)

-- Center search match
map('n', 'N', 'Nzz', opts)
map('n', 'n', 'nzz', opts)

-- Very magic search by default
map('n', '/', '/\\v', { noremap = true })
map('n', '?', '?\\v', { noremap = true })

-- Reverse star search
map('n', '&', '*?<cr>n', opts)

-- Terminal:
-- ctrl-n for normal mode - need esc key for zsh vim mode
map('t', '<C-n>', '<C-\\><C-n>', opts)

-- Diagnostics
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Clear search highight on escape
map("n", "<Esc>", "<cmd> :noh <CR>", {})

-- Indent stay in visual mode
-- map("v", "<", "<gv", opts)
-- map("v", ">", ">gv", opts)
-- map("v", ".", ":normal .<cr>", opts)

-- Debugger:

widgets = require('dap.ui.widgets')
scopes_sidebar = widgets.sidebar(widgets.scopes)
frames_sidebar = widgets.sidebar(widgets.frames)
expression_sidebar = widgets.sidebar(widgets.expression)
threads_sidebar = widgets.sidebar(widgets.threads)

map('n', '<F5>', '<cmd>lua dap.continue()<CR>', opts)
map('i', '<F5>', '<cmd>lua dap.continue()<CR>', opts)
map('n', '<F9>', '<cmd>lua dap.toggle_breakpoint()<CR>', opts)
map('i', '<F9>', '<cmd>lua dap.toggle_breakpoint()<CR>', opts)
map('n', '<F10>', '<cmd>lua dap.step_over()<CR>', opts)
map('i', '<F10>', '<cmd>lua dap.step_over()<CR>', opts)
map('n', '<F11>', '<cmd>lua dap.step_into()<CR>', opts)
map('i', '<F11>', '<cmd>lua dap.step_into()<CR>', opts)
map('n', '<F12>', '<cmd>lua dap.step_out()<CR>', opts)
map('i', '<F12>', '<cmd>lua dap.step_out()<CR>', opts)

dap = require("dap")
dapui = require("dapui")

function start_debug()
  dap.continue()
  dapui.open()
end

function stop_debug()
  dap.terminate()
  dapui.close()
end

require("which-key").add({
  { "<leader>'", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
  { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  { "<leader><cr>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader><space>", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
  { "<leader><tab>", "<cmd>b#<cr>", desc = "Alternate buffer" },
  { "<leader>?", "<cmd>set spell!<cr>", desc = "Spelling toggle" },
  { "<leader>P", "<cmd>put!<cr>", desc = "Put above" },
  { "<leader>Q", "<cmd>q<cr>", desc = "Quit" },
  { "<leader>\\", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },

  { "<leader>[", "<cmd>AerialPrev<cr>", desc = "Previous symbol" },
  { "<leader>]", "<cmd>AerialNext<cr>", desc = "Next symbol" },

  { "<leader>b", group = "Buffer" },
  { "<leader>b?", "<cmd>ls<cr>", desc = "List" },
  { "<leader>bT", "<cmd>vsp|term<cr>", desc = "Terminal vertical split" },
  { "<leader>bW", "<cmd>wall<cr>", desc = "Write all" },
  { "<leader>ba", "<cmd>b#<cr>", desc = "Alternate" },
  { "<leader>be", "<cmd>enew<cr>", desc = "New" },
  { "<leader>bf", "<cmd>bfirst<cr>", desc = "First" },
  { "<leader>bl", "<cmd>blast<cr>", desc = "Last" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous" },
  { "<leader>bq", "<cmd>bdelete<cr>", desc = "Close" },
  { "<leader>bs", "<cmd>saveas", desc = "Save as..." },
  { "<leader>bt", "<cmd>sp|term<cr><cmd>resize 15<cr>", desc = "Terminal split" },
  { "<leader>bw", "<cmd>write<cr>", desc = "Write" },

  { "<leader>c", group = "Quickfix" },
  { "<leader>cc", "<cmd>cclose<cr>", desc = "Close" },
  { "<leader>co", "<cmd>copen<cr>", desc = "Open" },

  { "<leader>d", group = "Debug" },
  { "<leader>d?", '<cmd> lua require"dap".list_breakpoints() <cr>', desc = "List breakpoints" },
  { "<leader>dB", '<cmd> lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) <cr>', desc = "Set breakpoint condition" },
  { "<leader>dC", '<cmd> lua require"dap".clear_breakpoints() <cr>', desc = "Clear breakpoints" },
  { "<leader>dD", '<cmd> lua require"dap".down() <cr>', desc = "Move down stack" },
  { "<leader>dL", '<cmd> lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) <cr>', desc = "Log point" },
  { "<leader>dO", '<cmd> lua require"dap".step_out() <cr>', desc = "Step out" },
  { "<leader>dR", '<cmd> lua require"dap".run_to_cursor() <cr>', desc = "Run to cursor" },
  { "<leader>db", '<cmd> lua require"dap".toggle_breakpoint() <cr>', desc = "Toggle breakpoint" },
  { "<leader>dc", '<cmd> lua require"dap".continue() <cr>', desc = "Continue" },
  { "<leader>dd", "<cmd> lua start_debug() <cr>", desc = "Start" },
  { "<leader>de", '<cmd> lua require"dap".set_exception_breakpoints() <cr>', desc = "Exception breakpoint" },
  { "<leader>di", '<cmd> lua require"dap".step_into() <cr>', desc = "Step into" },
  { "<leader>dk", '<cmd> lua require"dapui".eval() <cr>', desc = "Hover" },
  { "<leader>dl", '<cmd> lua require"dap".run_last() <cr>', desc = "Run last" },
  { "<leader>do", '<cmd> lua require"dap".step_over() <cr>', desc = "Step over" },
  { "<leader>dp", '<cmd> lua require"dap".pause() <cr>', desc = "Pause" },
  { "<leader>dr", '<cmd> lua require"dap".repl.toggle() <cr>', desc = "Repl" },
  { "<leader>dt", '<cmd> lua require"dap".terminate() <cr>', desc = "Terminate" },
  { "<leader>du", '<cmd> lua require"dap".up() <cr>', desc = "Move up stack" },

  { "<leader>dw", group = "Widgets" },
  { "<leader>dwe", "<cmd> lua expression_sidebar.toggle() <cr>", desc = "Expression" },
  { "<leader>dwf", "<cmd> lua frames_sidebar.toggle() <cr>", desc = "Frames" },
  { "<leader>dws", "<cmd> lua scopes_sidebar.toggle() <cr>", desc = "Scopes" },
  { "<leader>dwt", "<cmd> lua threads_sidebar.toggle() <cr>", desc = "Threads" },
  { "<leader>dx", "<cmd> lua stop_debug() <cr>", desc = "Stop" },

  { "<leader>f", group = "Find" },
  { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
  { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "All files" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
  { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },

  { "<leader>'", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", buffer = 1, desc = "Workspace symbols", remap = false },
  { "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", buffer = 1, desc = "Document symbols", remap = false },
  { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", buffer = 1, desc = "Workspace symbols", remap = false },

  { "<leader>g", group = "Git" },
  { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
  { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
  { "<leader>gd", "<cmd>Git diff<cr>", desc = "Diff" },
  { "<leader>gf", "<cmd>Git fetch<cr>", desc = "Fetch" },

  { "<leader>gl", group = "List" },
  { "<leader>glb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
  { "<leader>glc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
  { "<leader>gls", "<cmd>Telescope git_status<cr>", desc = "Status" },
  { "<leader>glx", "<cmd>Telescope git_stash<cr>", desc = "Stash" },
  { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },

  { "<leader>h", group = "Gitsigns" },

  { "<leader>i", group = "Init" },
  { "<leader>ie", "<cmd>edit ~/.config/nvim/init.lua<cr>", desc = "Edit" },
  { "<leader>ir", "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Reload" },
  { "<leader>j", 'J"_x', desc = "Join" },

  { "<leader>l", group = "Language" },
  { "<leader>m", "<cmd>Make<cr>", desc = "Make" },
  { "<leader>p", "<cmd>put<cr>", desc = "Put" },
  { "<leader>q", "<cmd>bd<cr>", desc = "Close buffer" },
  { "<leader>r", "<cmd>Make run<cr>", desc = "Make run" },

  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",  desc = "Code action", remap = false },
  { "<leader>ld", "<cmd>Telescope lsp_document_symbols<cr>",  desc = "Document symbols", remap = false },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>",  desc = "Format", remap = false },
  { "<leader>lo", "<cmd>SymbolsOutline<cr>",  desc = "Outline", remap = false },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",  desc = "Rename", remap = false },
  { "<leader>ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",  desc = "Workspace symbols", remap = false },

  { "<leader>lt", group = "Typescript" },
  { "<leader>lta", "<cmd>TSToolsAddMissingImports<cr>",  desc = "Add missing imports", remap = false },
  { "<leader>ltd", "<cmd>TSToolsGoToSourceDefinition<cr>",  desc = "Goes to source definition", remap = false },
  { "<leader>ltf", "<cmd>TSToolsFixAll<cr>",  desc = "Fix all fixable errors", remap = false },
  { "<leader>lto", "<cmd>TSToolsOrganizeImports<cr>",  desc = "Organize imports", remap = false },
  { "<leader>ltr", "<cmd>TSToolsRenameFile<cr>",  desc = "Rename file", remap = false },
  { "<leader>lts", "<cmd>TSToolsSortImports<cr>",  desc = "Sort imports", remap = false },
  { "<leader>ltu", "<cmd>TSToolsRemoveUnused<cr>",  desc = "Remove unused", remap = false },

  { "<leader>lw", group = "Workspace" },
  { "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",  desc = "Add folder", remap = false },
  { "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",  desc = "List folders", remap = false },
  { "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",  desc = "Remove folder", remap = false },

  { "<leader>t", group = "Trouble" },
  { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
  { "<leader>tl", "<cmd>Trouble loclist<cr>", desc = "Location list" },
  { "<leader>tq", "<cmd>Trouble quickfix<cr>", desc = "Quickfix" },

  { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  { "<leader>w", "<cmd>w<cr>", desc = "Write buffer" },

  { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
})
