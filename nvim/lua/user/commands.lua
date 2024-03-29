-- nvim_define_autocmd coming in 0.7
vim.cmd[[autocmd FileType help wincmd L]] -- Open help on right

-- Fix common command typos
-- todo: vim.api.nvim_create_user_command?
vim.cmd[[
  command! -bang -nargs=? -complete=file E e<bang> <args>
  command! -bang -nargs=? -complete=file W w<bang> <args>
  command! -bang -nargs=? -complete=file Wq wq<bang> <args>
  command! -bang -nargs=? -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
]]

-- Default spelling on for file types
vim.cmd[[
  augroup enableSpelling
    autocmd!
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd FileType gitcommit setlocal spell
  augroup end
]]

vim.cmd[[
  augroup terminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup end
]]

vim.cmd[[
  command -nargs=* Make make <args>|Trouble quickfix
]]

vim.cmd[[
  augroup dap
    autocmd!
    autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
    autocmd FileType dap-repl setlocal nonumber norelativenumber
    autocmd BufWinEnter,WinEnter \[dap-repl\]* startinsert
    autocmd BufLeave \[dap-repl\]* stopinsert
  augroup end
]]

vim.cmd[[
  augroup asm68k
  autocmd!
  autocmd FileType asm68k setlocal commentstring=;\ %s
  augroup end
]]

-- Whitespace per file type
vim.cmd[[
  autocmd FileType cpp setlocal ts=4 sw=4 sts=0 noexpandtab
  autocmd FileType c setlocal ts=4 sw=4 sts=0 noexpandtab
]]
