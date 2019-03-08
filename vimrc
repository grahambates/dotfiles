call plug#begin('~/.vim/plugged')

" Make vim's defaults match nvim
  if !has('nvim')
    Plug 'tpope/vim-sensible'
  endif

" Navigation
  Plug 'christoomey/vim-tmux-navigator'
  " Complementary pairs of mappings with ][
  Plug 'tpope/vim-unimpaired'
  " Nicer file navigator
  Plug 'justinmk/vim-dirvish'
  " Vim sugar for the UNIX shell commands e.g. Rename, Delete
  Plug 'tpope/vim-eunuch'
	" highlights which characters to target for f, F and family
  Plug 'unblevable/quick-scope'

" Editing
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'mbbill/undotree'
  " Align characters with ga
  Plug 'junegunn/vim-easy-align'
	" Register preview
  Plug 'junegunn/vim-peekaboo'

" Appearance
  Plug 'itchyny/lightline.vim'
  Plug 'chriskempson/base16-vim'

" Search
  Plug 'mileszs/ack.vim'
  Plug 'nelstrom/vim-visual-star-search'
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Formatting
  Plug 'w0rp/ale'

" Utility
  Plug 'tpope/vim-fugitive'

" Languages
  " Javascript
  Plug 'mxw/vim-jsx' " Need to load on startup to enable filetypes
  Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'alampros/vim-styled-jsx', { 'for': 'javascript' }
  Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
  Plug 'Quramy/vim-js-pretty-template', { 'for': 'javascript' }
  Plug 'hdima/python-syntax', { 'for': 'python' }

  " Typescript
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'mhartington/nvim-typescript', { 'for': 'typescript' }
  Plug 'peitalin/vim-jsx-typescript', { 'for': 'typescript' }

  " PHP
  Plug 'StanAngeloff/php.vim', { 'for': 'php' }
  Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
  Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }

  " Markdown
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

  " Elm
  Plug 'elmcast/elm-vim', { 'for': 'elm' }

call plug#end()

" General
  map <Space> <Leader>
  set shortmess+=filmnrxcoOtT " Abbrev. of messages (avoids 'hit enter')
  set wildmode=longest,list,full " Better command completion
  " Keyboard mash to escape
  imap jk <Esc>
  imap kj <Esc>
  set scrolloff=10
  let base16colorspace=256  " Access colors present in 256 colorspace
  colorscheme base16-phd
  if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
  endif
  hi LineNr ctermbg=black
  hi LineNr ctermfg=darkgrey
  hi xmlEndTag ctermfg=blue
  hi jsxCloseString ctermfg=blue
  hi jsxAttrib ctermfg=yellow
  hi jsxAttributeBraces ctermfg=lightblue

  nnoremap <Leader>ev :edit ~/.vimrc <enter>
  nnoremap <Leader>sv :source ~/.vimrc <enter>

  " Disable seldom used commands
  nnoremap Q <nop>

" Explore
  nnoremap <Leader>e :Dirvish <enter>
  nnoremap <Leader>E :Explore <enter>
  let g:netrw_liststyle=3

" System
  set mouse=a " Enable mouse
  "set mouse= " Disable mouse
  " Fix mouse select in iTerm - not needed in neovim
  if !has('nvim')
    set ttymouse=xterm2
  endif
  " Temp files
  "set nobackup
  "set noswapfile
  set undofile
  set directory=$HOME/.vim/swapfiles//

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
  " Clear search highlight and redraw
  nnoremap <leader>c :nohls <enter> :redraw! <enter>

" Buffers
  set hidden " Hide unsaved buffers
  set confirm " Ask about unsaved changes
  nnoremap <Leader>w :w <enter>
  nnoremap <Leader>q :bd <enter>
  nnoremap <Leader>Q :qall <enter>

" Splits
  "set splitbelow " Default split directions
  "set splitright
  "set fillchars= " Get rid of '|' in vertical split
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
    nnoremap <leader>? :set spell!<CR>
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

" Folding
  set foldmethod=syntax
  set foldlevel=99

" Terminal
  tnoremap <C-n> <C-\><C-n>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  autocmd TermOpen * startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

" Completion
  set completeopt=menu,preview

" Abbreviations
  abbr @@ hello@grahambates.com

" Plugins {{{
"

  " Ack
    let g:ackprg = 'ag --vimgrep'

  " FZF
    nmap <leader>fb :Buffers<CR>
    nmap <leader><tab> :Buffers<CR>
    nmap <leader>ff :Files<CR>
    nmap <leader><CR> :Files<CR>
    nmap <leader>fm :Marks<CR>
    nmap <leader>fw :Windows<CR>
    nmap <leader>fg :GFiles<CR>
    nmap <leader>fa :Ag<CR>
    nmap <leader>/ :Ag<CR>

  " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gc :Gcommit<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gf :Gfetch<CR>

  " Javascript
    let g:javascript_plugin_jsdoc = 1 " Enable sytax highlighting for docblocks

  " JSX
    let g:jsx_ext_required = 0

  " PHP namespace
    function! IPhpInsertUse()
      call PhpInsertUse()
      call feedkeys('a',  'n')
    endfunction
    autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR

  " Markdown
    let g:vim_markdown_folding_disabled = 1

  " Undo tree
    nmap <leader>u :UndotreeToggle<CR>

  " ALE
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'javascript.jsx': ['eslint'],
    \   'typescript': ['tslint']
    \}
    let g:ale_fixers = {
    \  'javascript': ['eslint'],
    \  'javascript.jsx': ['eslint'],
    \  'typescript': ['tslint']
    \}
    let g:ale_javascript_eslint_use_global = 1
    let g:ale_javascript_eslint_executable = 'eslint_d'
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 1
    nnoremap <leader>F :call QuickAleFix()<CR>
    nnoremap <leader>f :ALEFix<CR>

    " Disable syntax while running fixer
    function! QuickAleFix()
      set syntax=
      ALEFix
      sleep 1000m
      set syntax=on
    endfunction

  " Tern
    let g:tern_map_keys = 1

  " Quick Scope
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " Disable cursor keys
    inoremap <Left>  <NOP>
    inoremap <Right> <NOP>
    inoremap <Up>    <NOP>
    inoremap <Down>  <NOP>
    nnoremap <Left>  <NOP>
    nnoremap <Right> <NOP>
    nnoremap <Up>    <NOP>
    nnoremap <Down>  <NOP>

  " Python
    let python_highlight_all = 1
    let g:python_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
" }}}
