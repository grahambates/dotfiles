#!/bin/bash
git submodule update --init --recursive

ln -s ~/dotfiles/nvim/ ~/.config/nvim
ln -s ~/dotfiles/omf/ ~/.config/omf
ln -s ~/dotfiles/spacemacs ~/.spacemacs
ln -s ~/dotfiles/tmux ~/.tmux
ln -s ~/dotfiles/gitignore ~/.gitignore
ln -s ~/dotfiles/gitignore ~/.gitingore
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/tern-config ~/.tern-config
ln -s ~/dotfiles/tmux-powerlinerc ~/.tmux-powerline
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vim ~/.vim

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

cd ~/.vim/bundle/tern_for_vim
npm install
