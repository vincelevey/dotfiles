# zsh profile for OS X
export ZSH="${HOME}/.oh-my-zsh"
export TERM='xterm-256color'

DEFAULT_USER=$USERNAME
ZSH_THEME='agnoster'

# plugins
plugins=(
  brew
  git
  history
  ripgrep
)

# Bash completion compatibility
autoload -Uz compinit && compinit

if [[ $TERM_PROGRAM == 'iTerm.app' ]]; then
  plugins+=(iterm2)
  zstyle :omz:plugins:iterm2 shell-integration yes
fi
source ${ZSH}/oh-my-zsh.sh

if [[ $TERM_PROGRAM == 'vscode' ]]; then
  alias rg='rg --smart-case --hidden --no-heading --column'
  export EDITOR='code --wait'
  export VISUAL="${EDITOR}"
else
  alias rg='rg --smart-case --hidden'
fi

