nvm use 8

# Disable right prompt
function fish_right_prompt
end

set fish_key_bindings fish_vi_key_bindings
set fish_bind_mode insert
export EDITOR=nvim

# Preview for fzf
function fzf_preview
  if test -d $argv
    echo $argv is a directory
  end
  if test -f $argv
    switch (file --mime $argv)
      case '*binary'
        echo $argv is a binary file
      case '*'
        rougify $argv
    end
  end
end

export FZF_DEFAULT_OPTS="--preview 'fzf_preview {}'"
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export POWERLINE_CONFIG_COMMAND=Library/Python/3.6/bin/powerline-config

# Add project npm bin to path
export PATH="./node_modules/.bin:$PATH"

set -x PATH "$HOME/.pyenv/bin" $PATH
. (pyenv init - | psub)

alias mux=tmuxinator
alias vim=nvim
alias vi=nvim
