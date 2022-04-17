local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true, silent = true }

-- Keyboard mash to escape
-- Replaced by better-escape.nvim
-- map('i', 'jk', '<Esc>', {})
-- map('i', 'kj', '<Esc>', {})

-- Buffers:
map('n', '<Leader>w', ':w <enter>', options)
map('n', '<Leader>q', ':bd <enter>', options)
map('n', '<Leader>Q', ':qall <enter>', options)

-- Paste on new line
map('n', '<Leader>p', ':put <enter>', options)
map('n', '<Leader>P', ':put! <enter>', options)

-- More convenient mappings for standard commands
map('n', 'H', '^', options)
map('n', 'Q', '@@', options)

-- Delete without clobbering unnamed register
map('n', 's', '"_d', options)

-- Join without space
map('n', '<Leader>j', 'J"_x', options)

-- Toggle spelling
map('n', '<Leader>?', ':set spell!<CR>', options)

-- Make current file
map('n', '<Leader>m', ':make % <enter>', options)

-- init.lua shortcuts
map('n', '<Leader>ev', ':edit ~/.config/nvim/init.lua <enter>', options)
map('n', '<Leader>sv', ':source ~/.config/nvim/init.lua <enter>', options)

-- Disable seldom used commands
map('n', 'Q', '<nop>', options)

-- Search / replace:
-- Clear search highlight and redraw
map('n', '<Leader>c', ':nohls <enter> :redraw! <enter>', options) 
-- Center search match
map('n', 'N', 'Nzz', options)
map('n', 'n', 'nzz', options)
-- replace the word under cursor
map('n', '<Leader>*', [[:%s/\<<c-r><c-w>\>//g<left><left>]], options) 

-- File navigation
map('n', '<Leader>e', ':Dirvish <enter>', options)
map('n', '<Leader>E', ':Explore <enter>', options)

-- Telescope
map('n', '<Leader><TAB>', '<cmd>Telescope buffers<cr>', options)
map('n', '<Leader><CR>', '<cmd>Telescope find_files<cr>', options)
map('n', '<Leader>/', '<cmd>Telescope live_grep<cr>', options)
map('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', options)

-- Fugitive
map('n', '<Leader>gs', ':Gstatus<CR>', options)
map('n', '<Leader>gc', ':Gcommit<CR>', options)
map('n', '<Leader>gd', ':Gdiff<CR>', options)
map('n', '<Leader>gb', ':Gblame<CR>', options)
map('n', '<Leader>gf', ':Gfetch<CR>', options)

-- Undo tree
map('n', '<Leader>u', ':UndotreeToggle<CR>', options)

-- Terminal:
-- ctrl-n for normal mode - need esc key for zsh vim mode
map('t', '<C-n>', '<C-\\><C-n>', options)
-- Window movements
map('t', '<C-h>', '<C-\\><C-N><C-w>h', options)
map('t', '<C-j>', '<C-\\><C-N><C-w>j', options)
map('t', '<C-k>', '<C-\\><C-N><C-w>k', options)
map('t', '<C-l>', '<C-\\><C-N><C-w>l', options)

-- vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
-- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
