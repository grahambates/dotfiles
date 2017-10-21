call plug#begin('~/.vim/plugged')
" Make vim's defaults match nvim
	if !has('nvim')
		Plug 'tpope/vim-sensible'
	endif

" Navigation
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'easymotion/vim-easymotion'
	Plug 'tpope/vim-unimpaired'
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Editing
	Plug 'godlygeek/tabular'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
	Plug 'tommcdo/vim-lion'
	Plug 'editorconfig/editorconfig-vim'

" Appearance
	Plug 'itchyny/lightline.vim'
	Plug 'tomasr/molokai'

" Search
	Plug 'mileszs/ack.vim'
	Plug 'nelstrom/vim-visual-star-search'
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Formatting
	Plug 'w0rp/ale'
	Plug 'sbdchd/neoformat'

" Utility
	Plug 'tpope/vim-fugitive'

" Languages
	" Javascript
	Plug 'mxw/vim-jsx' " Need to load on startup to enable filetypes
	Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
	Plug 'alampros/vim-styled-jsx', { 'for': 'javascript' }
	Plug 'Galooshi/vim-import-js', { 'for': 'javascript' }
	Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
	Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
	" PHP
	Plug 'StanAngeloff/php.vim', { 'for': 'php' }
	Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
	Plug 'arnaud-lb/vim-php-namespace', { 'for': 'php' }
	" Markdown
	Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Completion
	Plug 'junegunn/fzf.vim'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


call plug#end()

" General
  map <Space> <Leader>
	map <Leader><Space> <Plug>(easymotion-prefix)
  set shortmess+=filmnrxcoOtT " Abbrev. of messages (avoids 'hit enter')
  set wildmode=longest,list,full " Better command completion
  " Keyboard mash to escape
  imap jk <Esc>
  imap kj <Esc>
  set scrolloff=10
	colorscheme molokai

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
  set textwidth=80 colorcolumn=+1 " Highlight maximum line length
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

" Folding
  set foldmethod=syntax
  set foldlevel=99

" Plugins {{{
"
  " Nerdtree
		nnoremap <Leader>e :NERDTreeToggle <enter>
		let g:NERDTreeShowHidden=1
		let g:NERDTreeIgnore=['\.git$', '\.npm$']

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
		nmap <leader>s :Ag<CR>

	" Deoplete
		call deoplete#enable()
		set completeopt+=noinsert
		let g:deoplete#sources#ternjs#filetypes = ['javascript', 'jsx', 'javascript.jsx', 'vue']

	" Neoformat
		augroup fmt
			autocmd!
			autocmd BufWritePre * undojoin | Neoformat
		augroup END

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
" }}}
