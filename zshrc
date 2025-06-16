# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="./node_modules/.bin:../../node_modules/.bin:/usr/local/opt/ruby/bin:$HOME/go/bin:$HOME/.composer/vendor/bin:$HOME/Library/Python/3.7/bin:$PATH" 
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/Users/batesgw1/.cargo/bin:$PATH"
export PATH="/Users/batesgw1/homebrew/bin:$PATH"
export PATH="/Users/batesgw1/Library/Android/sdk/platform-tools:$PATH"
# export PATH="/Users/batesgw1/amiga/bin:/Users/batesgw1/amiga/bin/bartman:/Users/batesgw1/amiga/bin/bartman/opt/bin/:$PATH"
# export PATH="/Users/batesgw1/projects/vscode-amiga-debug/bin/darwin:$PATH"
# export PATH="/Users/batesgw1/projects/vscode-amiga-debug/bin/darwin/opt/bin:$PATH"
#

# export TERM=vt100
eval $(thefuck --alias)


# export C_INCLUDE_PATH=/Users/batesgw1/homebrew/include
# export CPLUS_INCLUDE_PATH=/Users/batesgw1/homebrew/include

# Aspera client
export PATH=/Users/batesgw1/Applications/Aspera\ CLI/bin:$PATH
export MANPATH=/Users/batesgw1/Applications/Aspera\ CLI/share/man:$MANPATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/batesgw1/.oh-my-zsh"

export ZSH_DISABLE_COMPFIX=true

# Include paths
# export C_INCLUDE_PATH=/Users/batesgw1/homebrew/include
# export CPLUS_INCLUDE_PATH=/Users/batesgw1/homebrew/include

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=`whoami`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  brew
  common-aliases
  docker
  docker-compose
  golang
  history-substring-search
  npm
  nvm
  macos
  tmux
  vi-mode
  fzf
  yarn
  z
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="nvim"
alias vim="nvim"
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# BBCW Digital
alias sshu='sshuttle -r bastion 10.0.0.0/12 --dns --pidfile /tmp/sshuttle_digital.pid'
alias ecsauth='aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 763459770974.dkr.ecr.eu-west-1.amazonaws.com'

bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# FZF
export FZF_DEFAULT_OPTS="--preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file ||
 (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500'"
export FZF_DEFAULT_COMMAND='rg --files --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export BAT_THEME="TwoDark"

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Per the security update https://groups.google.com/forum/#!topic/golang-announce/X7N1mvntnoU you may need whitelist the
# -Xpreprocessor flag in your environment.
export CGO_CFLAGS_ALLOW='-Xpreprocessor'

alias luamake=/Users/batesgw1/tools/lua-language-server/3rd/luamake/luamake

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# export PATH="/usr/local/opt/php@7.4/bin:$PATH"
# export PATH="/usr/local/opt/php@7.4/sbin:$PATH"

# bun completions
[ -s "/Users/batesgw1/.bun/_bun" ] && source "/Users/batesgw1/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2024-08-07 23:12:51
export PATH="$PATH:/Users/BatesGW1/.local/bin"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
