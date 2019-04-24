call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'sheerun/vim-polyglot'
call plug#end()

" System
  set mouse=a " Enable mouse
  set clipboard^=unnamed " Use system clipboard
  set undofile
  set directory=$HOME/.vim/swapfiles//

  map <Space> <Leader>
  " Keyboard mash to escape
  imap jk <Esc>
  imap kj <Esc>
  " Paste on new line
  nnoremap <Leader>p :put <enter>
  nnoremap <Leader>P :put! <enter>

" Formatting
  set expandtab
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2

" Search
  set ignorecase smartcase " Case insensitive search - Unless begins with uppercase
  set gdefault " use global flag by default in s: commands
  set hlsearch " Highlight search
  " Always keep search results in the center.
  map N Nzz
  map n nzz
  " Clear search highlight and redraw
  nnoremap <leader>c :nohls <enter> :redraw! <enter>
  " Replace grep program
  if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif

" Buffers
  set hidden " Hide unsaved buffers
  set confirm " Ask about unsaved changes
  nnoremap <Leader>w :w <enter>
  nnoremap <Leader>q :bd <enter>
  nnoremap <Leader>Q :qall <enter>
