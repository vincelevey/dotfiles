# zsh profile for macOS
export ZSH="${HOME}/.oh-my-zsh"
export TERM='xterm-256color'
export LESS='-FR'

DEFAULT_USER=$USERNAME
ZSH_THEME='agnoster'

# plugins
plugins=(
  brew
  git
  history
  ripgrep
)

if [[ $TERM_PROGRAM == 'iTerm.app' ]]; then
  plugins+=(iterm2)
  zstyle :omz:plugins:iterm2 shell-integration yes
fi
source ${ZSH}/oh-my-zsh.sh

# Bash completion compatibility
autoload -Uz compinit && compinit

if [[ $TERM_PROGRAM == 'vscode' ]]; then
  alias rg='rg --smart-case --hidden --no-heading --column'
  export EDITOR='code --wait'
  export VISUAL="${EDITOR}"
else
  alias rg='rg --smart-case --hidden'
fi
