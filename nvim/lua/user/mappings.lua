local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opts = { noremap = true, silent = true }

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts) -- conflict?
map("n", "<C-l>", "<C-w>l", opts)

map("i", "<C-h>", "<C-w>h", opts)
map("i", "<C-j>", "<C-w>j", opts)
map("i", "<C-k>", "<C-w>k", opts)
map("i", "<C-l>", "<C-w>l", opts)

-- More convenient mappings for standard commands
map('n', 'H', '^', opts)
map('n', 'Q', '@@', opts)

-- Delete without clobbering unnamed register
map('n', 's', '"_d', opts)

-- Center search match
map('n', 'N', 'Nzz', opts)
map('n', 'n', 'nzz', opts)

-- Terminal:
-- ctrl-n for normal mode - need esc key for zsh vim mode
map('t', '<C-n>', '<C-\\><C-n>', opts)
-- -- Window movements
map('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- Diagnostics
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Clear search highight on escape
map("n", "<Esc>", "<cmd> :noh <CR>", {})

-- Indent stay in visual mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- map("v", ".", ":normal .<cr>", opts)

vim.cmd[[
  nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
  nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
  nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
  nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
]]

widgets = require('dap.ui.widgets')
scopes_sidebar = widgets.sidebar(widgets.scopes)
frames_sidebar = widgets.sidebar(widgets.frames)
expression_sidebar = widgets.sidebar(widgets.expression)
threads_sidebar = widgets.sidebar(widgets.threads)

require("which-key").register({
  -- Buffers
  w = { '<cmd>w<cr>', "Write buffer" },
  q = { '<cmd>bd<cr>', "Close buffer" },
  Q = { '<cmd>q<cr>', "Quit" },

  b = {
    name = "Buffer",
    e = { '<cmd>enew<cr>', "New" },
    w = { '<cmd>write<cr>', "Write" },
    W = { '<cmd>wall<cr>', "Write all" },
    s = { '<cmd>saveas', "Save as..." },
    q = { '<cmd>bdelete<cr>', "Close" },
    a = { '<cmd>ball<cr>', "Show all" },
    ["?"] = { '<cmd>ls<cr>', "List" },
    f = { '<cmd>bfirst<cr>', "First" },
    l = { '<cmd>blast<cr>', "Last" },
    n = { '<cmd>bnext<cr>', "Next" },
    p = { '<cmd>bprevious<cr>', "Previous" },
    a = { '<cmd>b#<cr>', "Alternate" },
  },

  -- Find (Telescope)
  ["<tab>"] = { "<cmd>b#<cr>", "Alternate buffer" },
  ["\\"] = { "<cmd>Telescope buffers<cr>", "Find buffers" },
  ["<cr>"] = { "<cmd>Telescope find_files<cr>", "Find files" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Grep" },

  f = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Files" },
    a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", "All files" },
    o = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    r = { "<cmd>Telescope registers<cr>", "Registers" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
  },

  -- Git (Fugitive)
  g = {
    name = "Git",
    s = { "<cmd>Git<cr>", "Status" },
    c = { "<cmd>Git commit<cr>", "Commit" },
    d = { "<cmd>Git diff<cr>", "Diff" },
    b = { "<cmd>Git blame<cr>", "Blame" },
    f = { "<cmd>Git fetch<cr>", "Fetch" },
    l = {
      name = "List",
      s = { "<cmd>Telescope git_status<cr>", "Status" },
      c = { "<cmd>Telescope git_commits<cr>", "Commits" },
      b = { "<cmd>Telescope git_branches<cr>", "Branches" },
      x = { "<cmd>Telescope git_stash<cr>", "Stash" },
    }
  },

  -- Trouble
  t = {
    name = "Trouble",
    t = { "<cmd>Trouble<cr>", "Open" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document" },
    l = { "<cmd>Trouble loclist<cr>", "Location list" },
    q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
  },

  -- Quickfix
  c = {
    name = "Quickfix",
    o = { "<cmd>copen<cr>", "Open" },
    c = { "<cmd>cclose<cr>", "Close" },
  },

  -- Config - init.lua
  i = {
    name = "Init",
    e = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "Edit" },
    r = { "<cmd>source ~/.config/nvim/init.lua<cr>", "Reload" },
  },

  -- Put
  p = { "<cmd>put<cr>", "Put" },
  P = { "<cmd>put!<cr>", "Put above" },

  l = {
    name = "Language"
  },

  -- Misc
  u = { "<cmd>UndotreeToggle", "Undotree" },
  j = { 'J"_x', "Join" },
  ["?"] = { '<cmd>set spell!<cr>', "Spelling toggle" },
  m = { '<cmd>Make<cr>', "Make" },

  d = {
    name = "Debug",
    b = { '<cmd> lua require"dap".toggle_breakpoint() <cr>', 'Toggle breakpoint' },
    B = { '<cmd> lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) <cr>', 'Set breakpoint condition' },
    C = { '<cmd> lua require"dap".clear_breakpoints() <cr>', 'Clear breakpoints' },
    ['?'] = { '<cmd> lua require"dap".list_breakpoints() <cr>', 'List breakpoints' },
    c = { '<cmd> lua require"dap".continue() <cr>', 'Continue' },
    o = { '<cmd> lua require"dap".step_over() <cr>', 'Step over' },
    O = { '<cmd> lua require"dap".step_out() <cr>', 'Step out' },
    i = { '<cmd> lua require"dap".step_into() <cr>', 'Step into' },
    r = { '<cmd> lua require"dap".repl.toggle() <cr>', 'Repl' },
    l = { '<cmd> lua require"dap".run_last() <cr>', 'Run last' },
    L = { '<cmd> lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) <cr>', 'Log point' },
    t = { '<cmd> lua require"dap".terminate() <cr>', 'Terminate' },
    p = { '<cmd> lua require"dap".pause() <cr>', 'Pause' },
    R = { '<cmd> lua require"dap".run_to_cursor() <cr>', 'Run to cursor' },
    k = { '<cmd> lua widgets.hover() <cr>', 'Hover' },
    w = {
      name = 'Widgets',
      s = { '<cmd> lua scopes_sidebar.toggle() <cr>', 'Scopes' },
      f = { '<cmd> lua frames_sidebar.toggle() <cr>', 'Frames' },
      e = { '<cmd> lua expression_sidebar.toggle() <cr>', 'Expression' },
      t = { '<cmd> lua threads_sidebar.toggle() <cr>', 'Threads' },
    }
  }

}, { prefix = "<leader>" })
