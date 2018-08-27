# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/sidharthsatapathy/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders

plugins=(git wd sudo npm web-search docker macports brew node zsh-autosuggestions)

# POWERLEVEL9K_OS_ICON_BACKGROUND="241"
# POWERLEVEL9K_OS_ICON_FOREGROUND="223"

POWERLEVEL9K_DIR_HOME_BACKGROUND="92"
# 196 - red 202 - orange 208 - light orange 214 - lighter orange 220 - oragish yellow 226 - yellow 190 - yellowish green 154 - green 118 - light green 82 - deep light green 46 - deep green
# 124 - dark red 130 - dark brown 136 - brown 142 - slime brown 148 - slime green 112 - pale green 76 - green 40 - deep green 34 - dark green 28 - deeper green 22 - deepest darkest green
# 88 - deepest red 94 - deep brown 100 - odd yellow brown 106 - slime green 70 - green 34 - green 28 - dark green 22 - deepest darkest green
POWERLEVEL9K_DIR_HOME_FOREGROUND="300"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="92"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="300"

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='220'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='237'


POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='241'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='223'

# Git

POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch)

# Show last commit hash
POWERLEVEL9K_SHOW_CHANGESET='true'
POWERLEVEL9K_CHANGESET_HASH_LENGTH='7'

# Icons
# POWERLEVEL9K_VCS_COMMIT_ICON='\uE626 '
# POWERLEVEL9K_VCS_STAGED_ICON='\u271A'
# POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF113 '
# POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON='\uF171 '

HYPHEN_INSENSITIVE="true"

HIST_STAMPS="dd.mm.yyyy"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to dikble bi-weekly auto-update checks.
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# export NVM_DIR="/Users/sidharthsatapathy/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
# export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
# #export vim=/usr/local/Cellar/vim/bin/vim
# alias vim=nvim
# export EDITOR=nvim
# export GIT_EDITOR=nvim
# export PATH="$PATH":/Users/sidharthsatapathy/.local/bin

# #for tmux to use 256 colors
# export TERM=xterm-256color
# # added psvm path for purescript
# export PATH=$HOME/.psvm/current/bin:$PATH

# # android sdk
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$HOME/Library/Android/sdk/tools:$PATH
# export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH

# # haskell
# export PATH=$HOME/Library/Haskell/bin:$PATH
# export PATH=$HOME/.cabal/bin:$PATH

# # golang
# export GOPATH=$HOME/Documents/code/go
# export PATH=$GOPATH/bin:$PATH

# export SHELL=zsh
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # postgres
# alias pg-start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
# alias pg-stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # this is the armory flags
# export CFLAGS="-arch x86_64"
# export ARCHFLAGS="-arch x86_64"

# export PATH=/Users/sidharthsatapathy/.local/bin/luna-studio:$PATH

# for pyenv
# export PATH="/Users/sidharthsatapathy/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# nvim
alias vim=nvim
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
