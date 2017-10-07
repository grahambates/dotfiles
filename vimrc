" Setup
  " Don't need vim-sensible for neovim
  if has('nvim')
    let g:pathogen_disabled = ['vim-sensible']
  endif
  execute pathogen#infect()

" General
  colorscheme molokai
  let mapleader = ',' " Set leader to ','
  noremap \ , 
  set shortmess+=filmnrxcoOtT " Abbrev. of messages (avoids 'hit enter')
  set wildmode=longest,list,full " Better command completion
  " Keyboard mash to escape
  imap jk <Esc> 
  imap kj <Esc>
  set scrolloff=10

  " Disable seldom used commands
  nnoremap Q <nop>
  " nnoremap K <nop>

" System
  set mouse=a " Enable mouse
  " Fix mouse select in iTerm - not needed in neovim
  if !has('nvim')
    set ttymouse=xterm2 
  endif
  " Disable tmp files
  set nobackup
  set noswapfile
  " Centralise temporary files
  " set backupdir=~/.vim/backup//
  " set directory=~/.vim/swap//
  " set undodir=~/.vim/undo//

" Tabs
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  autocmd FileType php setlocal ts=4 sts=4 sw=4 et " PHP specific settings

" Search
  set ignorecase smartcase " Case insensitive search - Unless begins with uppercase
  set gdefault " use global flag by default in s: commands
  set hlsearch " Highlight search
  " Always keep search results in the center.
  map N Nzz
  map n nzz
  " Clear search highlight
  nnoremap <Leader>/ :nohls <enter>

" Buffers
  set hidden " Hide unsaved buffers
  set confirm " Ask about unsaved changes
  nnoremap <Leader>w :w <enter>
  nnoremap <Leader>q :bd <enter>
  nnoremap <Leader>Q :qall <enter>

" Splits
  set splitbelow " Default split directions
  set splitright
  set fillchars= " Get rid of '|' in vertical split
  autocmd FileType help wincmd L " Open help on right

" Registers
  set clipboard^=unnamed " Use system clipboard
  " Paste on new line
  nnoremap <Leader>p :put <enter>
  nnoremap <Leader>P :put! <enter>

" Wildignore patterns
  set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF " Binary files
  set wildignore+=.git,vendor,node_modules,reports,.idea " Project and vendor dirs

" Visual guides
  set textwidth=120 colorcolumn=+1 " Highlight maximum line length
  set cursorline " Highlight line with cursor
  set number relativenumber " Show relative line numbers
  set showcmd " Show the command being typed
  set noshowmode " Shown through statusline
  " Change cursor shape between insert and normal mode in iTerm3.app
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

" Spelling
  if has("spell")
    set spelllang=en_gb
    nnoremap <leader>s :set spell!<CR>
  endif

" Fix common command typos
  if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif

" Plugins {{{

  " Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_javascript_checkers = ['eslint']

  " Javascript
    let g:javascript_plugin_jsdoc = 1 " Enable sytax highlighting for docblocks

  " JSX
    let g:jsx_ext_required = 0

  " Ack
    let g:ackprg = 'ag --vimgrep'

  " CtrlP
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " PHP Namespace
    function! IPhpInsertUse()
      call PhpInsertUse()
      call feedkeys('a',  'n')
    endfunction
    autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR

  " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gc :Gcommit<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gf :Gfetch<CR>

  " NERDTree
    nnoremap <Leader>e :NERDTreeToggle <enter>
    let g:NERDTreeShowHidden=1
    let g:NERDTreeIgnore=['\.git$', '\.npm$']
    " open a NERDTree automatically when vim starts up if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Dash
    nmap <silent> <leader>d <Plug>DashSearch

  " Markdown
    let g:vim_markdown_folding_disabled = 1 

  " Neoformat
    augroup fmt
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
    augroup END
" }}}
