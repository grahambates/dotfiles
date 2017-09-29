nvm use 8

# Disable right prompt
function fish_right_prompt
end

set fish_key_bindings fish_vi_key_bindings
set fish_bind_mode insert
export EDITOR=vim

alias mux=tmuxinator
