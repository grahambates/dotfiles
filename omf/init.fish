#nvm use 8

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

# emacs ansi-term support
if test -n "$EMACS"
		set -x TERM eterm-color
else
	# Base16 Shell
	if status --is-interactive
      # eval sh $HOME/.config/base16-shell/scripts/base16-gruvbox-dark-medium.sh
      # eval sh $HOME/.config/base16-shell/scripts/base16-harmonic-dark.sh
      # eval sh $HOME/.config/base16-shell/scripts/base16-outrun-dark.sh
      eval sh /Users/batesgw1/.config/base16-shell/scripts/base16-phd.sh
	end
end

export FZF_DEFAULT_OPTS="--preview 'fzf_preview {}'"
# export FZF_DEFAULT_COMMAND='rg --files --follow'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

export POWERLINE_CONFIG_COMMAND=Library/Python/3.6/bin/powerline-config

# Add project npm bin to path
export PATH="./node_modules/.bin:$PATH"

# Add brew ruby to path
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths

export PATH="$HOME/go/bin:$PATH"

alias mux=tmuxinator
alias vim=nvim
alias vi=nvim
