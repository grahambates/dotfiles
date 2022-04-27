local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.number = true -- Show relative line numbers
opt.relativenumber = true
opt.mouse = 'a' -- Enable mouse
opt.clipboard:append 'unnamedplus' -- Use system clipboard
opt.ignorecase = true -- caSe insensitive search 
opt.smartcase = true -- ...unless contains uppercase
opt.gdefault = true -- use global flag by default in s: commands
opt.undofile = true
opt.shortmess:append 'filmnrxcoOtT' -- Abbrev. of messages (avoids 'hit enter')
opt.autowrite = true -- Save before :make
opt.dictionary = '/usr/share/dict/words'
opt.scrolloff = 10 -- Keep 10 lines in view
opt.wildmode = 'longest,list,full' -- Better command completion
opt.wildignore:append { '*.png', '*.PNG', '*.JPG', '*.jpg', '*.JPEG', '*.jpeg', '*.GIF', '*.gif', '*.pdf', '*.PDF' } -- Binary files
opt.wildignore:append { '.git', 'vendor', 'node_modules', '.idea', '.vscode' } -- Project and vendor dirs
opt.completeopt = 'menu,menuone,noselect'
opt.complete:append 'kspell'
opt.termguicolors = true
opt.textwidth = 120
opt.colorcolumn = '+1' -- Highlight maximum line length
opt.cursorline = true -- Highlight line with cursor
opt.showmode = false -- Shown through statusline
opt.foldmethod = 'syntax'
opt.foldlevel = 99
opt.foldcolumn = '1'
opt.splitbelow = true
opt.splitright = true
opt.inccommand = 'nosplit' -- Substitute preview
opt.grepprg = "rg --hidden --glob '!.git' --vimgrep --with-filename"
opt.grepformat = '%f:%l:%c:%m'
opt.path = '.,**'

vim.g.filetype_i = "asm68k"
vim.g.asmsyntax = 'asm68k'
vim.cmd[[
set errorformat+=%E,%C%s\ %n\ in\ line\ %l\ of\ \"%f\":\ %m,%Z%s
]]
