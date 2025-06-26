-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.filetype_i = "asm68k"
vim.g.asmsyntax = "asm68k"
vim.cmd([[
" 1. Continuation lines containing location
" 2. Location is macro (no dot in filename) - don't map
" 3. Actual file/line number
" 4. Global errors with no location
set errorformat=\
            \%C\ \ \ \ \ \ \ \ called\ from\ line\ %l\ of\ \"%f\",\
            \%C\ \ \ \ \ \ \ \ included\ from\ line\ %l\ of\ \"%f\",\
            \%Eerror\ %n\ in\ line\ %*[0-9]\ of\ \"%*[a-zA-Z0-9_]\":\ %m,\
            \%Efatal\ error\ %n\ in\ line\ %*[0-9]\ of\ \"%*[a-zA-Z0-9_]\":\ %m,\
            \%Wwarning\ %n\ in\ line\ %*[0-9]\ of\ \"%*[a-zA-Z0-9_]\":\ %m,\
            \%Eerror\ %n\ in\ line\ %l\ of\ \"%f\":\ %m,\
            \%Efatal\ error\ %n\ in\ line\ %l\ of\ \"%f\":\ %m,\
            \%Wwarning\ %n\ in\ line\ %l\ of\ \"%f\":\ %m,\
            \%Eerror\ %n:\ %m,\
            \%Efatal\ error\ %n:\ %m,\
            \%Wwarning\ %n:\ %m
]])
