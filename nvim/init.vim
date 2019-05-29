call plug#begin('~/.vim/plugged')

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
  Plug 'machakann/vim-highlightedyank'
  " Align characters with ga
  Plug 'junegunn/vim-easy-align'
	" Register preview
  Plug 'junegunn/vim-peekaboo'

" Formatting
  Plug 'w0rp/ale'

" Appearance
  Plug 'itchyny/lightline.vim'
  Plug 'chriskempson/base16-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'morhetz/gruvbox'
  Plug 'rakr/vim-one'
  Plug 'nanotech/jellybeans.vim'
" Search
  Plug 'nelstrom/vim-visual-star-search'
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Utility
  Plug 'tpope/vim-fugitive'

" Languages
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'sheerun/vim-polyglot'
  Plug 'lervag/vimtex'

call plug#end()

" System
  set mouse=a " Enable mouse
  set clipboard^=unnamed " Use system clipboard
  set undofile
  set directory=$HOME/.vim/swapfiles//
  set shortmess+=filmnrxcoOtT " Abbrev. of messages (avoids 'hit enter')

  map <Space> <Leader>
  " Keyboard mash to escape
  imap jk <Esc>
  imap kj <Esc>
  " vimrc shortcuts
  nnoremap <Leader>ev :edit ~/.vimrc <enter>
  nnoremap <Leader>sv :source ~/.vimrc <enter>
  " Disable seldom used commands
  nnoremap Q <nop>
  " Paste on new line
  nnoremap <Leader>p :put <enter>
  nnoremap <Leader>P :put! <enter>
 
  "replace the word under cursor
  " nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>
  nnoremap <leader>* *N:%s//

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


" Editing
  set backspace= " Prevent backspace past start of edit
  set scrolloff=10
  abbr @@ hello@grahambates.com

" Completion
  set wildmode=longest,list,full " Better command completion
  set wildignore+=*.png,*.PNG,*.JPG,*.jpg,*.JPEG,*.jpeg,*.GIF,*.gif,*.pdf,*.PDF " Binary files
  set wildignore+=.git,vendor,node_modules,reports,.idea " Project and vendor dirs
  set completeopt=menu,preview

" Make
  set autowrite " Save before :make
  nnoremap <Leader>m :make % <enter>

" Appearance
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

  " Use 24-bit (true-color) mode
  if (has("termguicolors"))
    set termguicolors
  endif

  let g:palenight_terminal_italics=1
  let g:one_allow_italics=1
  let g:gruvbox_italic=1
  " colorscheme palenight
  colorscheme one

" File navigation
  nnoremap <Leader>e :Dirvish <enter>
  nnoremap <Leader>E :Explore <enter>
  let g:netrw_liststyle=3
  set path=.,**

" Formatting
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  autocmd FileType php setlocal ts=4 sts=4 sw=4 et " PHP specific settings

" Search
  set ignorecase smartcase " Case insensitive search - Unless begins with uppercase
  set gdefault " use global flag by default in s: commands
  set hlsearch " Highlight search
  set inccommand=nosplit " Substitute preview
  " Always keep search results in the center.
  map N Nzz
  map n nzz
  " Clear search highlight and redraw
  nnoremap <leader>c :nohls <enter> :redraw! <enter>
  " Replace grep program
  if executable("rg")
    set grepprg=rg\ --hidden\ --glob\ '!.git'\ --vimgrep\ --with-filename
    set grepformat=%f:%l:%c:%m
  endif

" Buffers
  set hidden " Hide unsaved buffers
  set confirm " Ask about unsaved changes
  nnoremap <Leader>w :w <enter>
  nnoremap <Leader>q :bd <enter>
  nnoremap <Leader>Q :qall <enter>

" Windows/splits
  "set splitbelow " Default split directions
  "set splitright
  autocmd FileType help wincmd L " Open help on right

" Spelling
  if has("spell")
    "set spelllang=en_gb
    nnoremap <leader>? :set spell!<CR>
    set complete+=kspell
    " Default on for file types
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd FileType gitcommit setlocal spell
  endif
  set dictionary=/usr/share/dict/words

" Folding
  set foldmethod=syntax
  set foldlevel=99
  set foldcolumn=1

" Terminal
	" ctrl-n for normal mode
	" Need esc key for zsh vim mode
  tnoremap <C-n> <C-\><C-n>
	" <C-r>{register} to paste register in terminal
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
	" Window movements
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
	" Always start in insert mode
  autocmd TermOpen * startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
	" https://github.com/neovim/neovim/issues/9483
  tmap <LeftRelease> <Nop>
	" No line numbers in terminal
  autocmd TermOpen * setlocal nonumber norelativenumber

" Plugins {{{

  " FZF
    nmap <leader>fb :Buffers<CR>
    nmap <leader><tab> :Buffers<CR>
    nmap <leader>ff :Files<CR>
    nmap <leader><CR> :Files<CR>
    nmap <leader>fm :Marks<CR>
    nmap <leader>fw :Windows<CR>
    nmap <leader>fg :GFiles<CR>
    nmap <leader>fa :Rg<CR>
    nmap <leader>/ :Rg<CR>

  " Fugitive
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gc :Gcommit<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gf :Gfetch<CR>

  " Javascript
    let g:javascript_plugin_jsdoc = 1 " Enable syntax highlighting for docblocks

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

  " Quick Scope
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " Highlight Yank
    let g:highlightedyank_highlight_duration = 250

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

  " Golang
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_types = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_fmt_autosave = 0
    let g:go_fmt_command = "goimports"
    let g:go_metalinter_autosave = 0
    let g:go_metalinter_command = 'golangci-lint'
    let g:go_metalinter_autosave_enabled = []
    let g:go_metalinter_enabled = []

    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <leader>T  <Plug>(go-test-func)
    autocmd FileType go nmap <leader>d  <Plug>(go-def)
    autocmd FileType go nmap <leader>h  <Plug>(go-doc)
    autocmd FileType go nmap <leader>i  <Plug>(go-info)
    autocmd FileType go nmap <leader>a  <Plug>(go-alternate-edit)
  
  " ALE
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'javascript.jsx': ['eslint'],
    \   'typescript': ['eslint'],
    \   'go': ['golangci-lint']
    \}
    let g:ale_fixers = {
    \  'javascript': ['eslint'],
    \  'javascript.jsx': ['eslint'],
    \  'typescript': ['eslint'],
    \  'go': ['goimports']
    \}
    let g:ale_javascript_eslint_use_global = 1
    let g:ale_javascript_eslint_executable = 'eslint_d'
    let g:ale_javascript_prettier_use_local_config = 1
    let g:ale_fix_on_save = 1
    let g:ale_go_golangci_lint_package = 1
    nnoremap <leader>f :ALEFix<CR>
    nnoremap <leader>l :ALENextWrap<CR>

  " Coc

    " Better display for messages
    set cmdheight=2
    " Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=300
    " always show signcolumns
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

  " Lightline
    function! CocCurrentFunction()
        return get(b:, 'coc_current_function', '')
    endfunction

    let g:lightline = {
        \ 'colorscheme': 'palenight',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status',
        \   'currentfunction': 'CocCurrentFunction'
        \ },
        \ }


" }}}
