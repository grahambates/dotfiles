local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opts = { noremap = true, silent = true }

-- Buffers:
map('n', '<Leader>w', ':w <enter>', opts)
map('n', '<Leader>q', ':bd <enter>', opts)
map('n', '<Leader>Q', ':qall <enter>', opts)

-- Paste on new line
map('n', '<Leader>p', ':put <enter>', opts)
map('n', '<Leader>P', ':put! <enter>', opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts) -- conflict?
map("n", "<C-l>", "<C-w>l", opts)

-- More convenient mappings for standard commands
map('n', 'H', '^', opts)
map('n', 'Q', '@@', opts)

-- Delete without clobbering unnamed register
map('n', 's', '"_d', opts)

-- Join without space
map('n', '<Leader>j', 'J"_x', opts)

-- Toggle spelling
map('n', '<Leader>?', ':set spell!<CR>', opts)

-- Make
map('n', '<Leader>m', ':Make <enter>', opts)

-- init.lua shortcuts
map('n', '<Leader>ev', ':edit ~/.config/nvim/init.lua <enter>', opts)
map('n', '<Leader>sv', ':source ~/.config/nvim/init.lua <enter>', opts)

-- Disable seldom used commands
map('n', 'Q', '<nop>', opts)

-- Search / replace:
-- Clear search highlight and redraw
map('n', '<Leader>c', ':nohls <enter> :redraw! <enter>', opts) 
-- Center search match
map('n', 'N', 'Nzz', opts)
map('n', 'n', 'nzz', opts)
-- replace the word under cursor
map('n', '<Leader>*', [[:%s/\<<c-r><c-w>\>//g<left><left>]], opts) 

-- File navigation
map('n', '<Leader>e', ':Dirvish <enter>', opts)
map('n', '<Leader>E', ':Explore <enter>', opts)

-- Telescope
map('n', '<Leader><TAB>', '<cmd>Telescope buffers<cr>', opts)
map('n', '<Leader><CR>', '<cmd>Telescope find_files<cr>', opts)
map('n', '<Leader>/', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- Fugitive
map('n', '<Leader>gs', ':Gstatus<CR>', opts)
map('n', '<Leader>gc', ':Gcommit<CR>', opts)
map('n', '<Leader>gd', ':Gdiff<CR>', opts)
map('n', '<Leader>gb', ':Gblame<CR>', opts)
map('n', '<Leader>gf', ':Gfetch<CR>', opts)

-- Undo tree
map('n', '<Leader>u', ':UndotreeToggle<CR>', opts)

-- Terminal:
-- ctrl-n for normal mode - need esc key for zsh vim mode
map('t', '<C-n>', '<C-\\><C-n>', opts)
-- -- Window movements
map('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

