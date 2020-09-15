# zsh profile for OS X
export ZSH="${HOME}/.oh-my-zsh"
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

export TERM='xterm-256color'

# eshell-style prompt with return code colours
PROMPT='%1~ %(?.%F{green}.%F{red})%#%f '

# path
path=(/usr/local/opt/coreutils/bin ${HOME}/bin $path)
EMACS_MAC_APP_PATH='/usr/local/opt/emacs-mac/bin'
[ -d $EMACS_MAC_APP_PATH ] && path=($EMACS_MAC_APP_PATH $path)
export PATH

# plugins
plugins=(
  brew
  emacs
  git
  history
  iterm2
  osx
  vagrant
)

# Bash completion compatibility
autoload -Uz compinit && compinit

source ${ZSH}/oh-my-zsh.sh
