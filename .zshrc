# =============================================================================
# .zshrc - Sidharth Satapathy (@xlreon)
# =============================================================================

# --- Oh-My-Zsh ---------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Disabled in favor of starship

# Enable cursor shape change for vi-mode (must be before oh-my-zsh loads)
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

plugins=(
  git
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh

# --- Vi-mode cursor shapes ---------------------------------------------------
# Beam (|) in insert mode, Block in normal mode
_set_cursor_insert() { echo -ne '\e[6 q'; }
_set_cursor_normal() { echo -ne '\e[2 q'; }

zle-keymap-select() {
  case $KEYMAP in
    vicmd)          _set_cursor_normal ;;
    viins|main|'')  _set_cursor_insert ;;
  esac
}
zle-line-init()   { _set_cursor_insert; }
zle-line-finish() { _set_cursor_normal; }

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

# --- PATH --------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# --- Homebrew (ARM Mac) ------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- mise (unified node/python/ruby version manager) ------------------------
eval "$(mise activate zsh)"

# --- Starship prompt ---------------------------------------------------------
eval "$(starship init zsh)"

# --- zoxide (smart cd, use 'z' instead of 'cd') -----------------------------
eval "$(zoxide init zsh)"

# --- fzf ---------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- pnpm --------------------------------------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# --- uv (Python package manager) --------------------------------------------
export PATH="$HOME/.cargo/bin:$PATH"

# --- Secrets (API keys, tokens - NOT committed to git) ----------------------
# Store all secrets in ~/.secrets - never commit that file!
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# --- Aliases: Navigation -----------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Aliases: Better defaults ------------------------------------------------
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias cat='bat --style=plain'
alias diff='delta'

# --- Aliases: Git ------------------------------------------------------------
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'
alias gd='git diff'
alias lg='lazygit'

# --- Aliases: npm/pnpm -------------------------------------------------------
alias ni='pnpm install'
alias nr='pnpm run'
alias nd='pnpm run dev'
alias nb='pnpm run build'

# --- Aliases: Python ---------------------------------------------------------
alias py='python3'
alias pip='uv pip'
alias venv='uv venv'

# --- Aliases: Docker ---------------------------------------------------------
alias dk='docker'
alias dkc='docker compose'
alias dku='docker compose up -d'
alias dkd='docker compose down'
alias dkl='docker compose logs -f'

# --- Aliases: Editor ---------------------------------------------------------
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias c='clear'
alias reload='source ~/.zshrc'
alias zshrc='nvim ~/.zshrc'

# --- Aliases: Network --------------------------------------------------------
alias ip='curl -s ifconfig.me'
alias ports='lsof -i -P -n | grep LISTEN'

# --- Aliases: Claude Code ----------------------------------------------------
alias ai='claude'

# --- Functions ---------------------------------------------------------------

# Create directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick Next.js project
new-next() {
  pnpm create next-app@latest "$1" --typescript --tailwind --eslint --app --src-dir
}

# Quick Python project with uv
new-py() {
  mkdir "$1" && cd "$1" && uv init && uv venv && source .venv/bin/activate
}

# Open current GitHub repo in browser
ghopen() {
  local remote
  remote=$(git remote get-url origin 2>/dev/null)
  if [ -n "$remote" ]; then
    open "${remote/git@github.com:/https://github.com/}"
  fi
}

# fzf git branch switcher
fbr() {
  local branch
  branch=$(git branch --all | grep -v HEAD | fzf +m) &&
  git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
}

# Kill process on a port
killport() { lsof -ti :"$1" | xargs kill -9; }

# --- tmux auto-attach (skip for VS Code / Cursor integrated terminals) -------
if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ] && [ "$TERM_PROGRAM" != "cursor" ]; then
  base_session='main'
  tmux has-session -t $base_session 2>/dev/null || tmux new-session -d -s $base_session
  client_cnt=$(tmux list-clients 2>/dev/null | wc -l)
  if [ "$client_cnt" -ge 1 ]; then
    session_name="${base_session}-${client_cnt}"
    tmux new-session -d -t $base_session -s $session_name
    tmux -2 attach-session -t $session_name \; set-option destroy-unattached
  else
    tmux -2 attach-session -t $base_session
  fi
fi
