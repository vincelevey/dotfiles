# zsh profile for macOS
export ZSH="${HOME}/.oh-my-zsh"
[ -r ~/.zsh_aliases ] && source ~/.zsh_aliases

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
  git
  helm
  history
  iterm2
  minikube
  osx
  vagrant
)

# Bash completion compatibility
autoload -Uz compinit && compinit

[ -r ${ZSH}/oh-my-zsh.sh ] && source ${ZSH}/oh-my-zsh.sh
