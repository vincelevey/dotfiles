# zsh profile for macOS
export ZSH="${HOME}/.oh-my-zsh"
export TERM='xterm-256color'
eval $(gdircolors)

# eshell-style prompt with return code colours
PROMPT='%1~ %(?.%F{green}.%F{red})%#%f '

# path
path=(/usr/local/opt/coreutils/bin ${HOME}/bin $path)
EMACS_MAC_APP_PATH='/usr/local/opt/emacs-mac/bin'
[ -d $EMACS_MAC_APP_PATH ] && path=($EMACS_MAC_APP_PATH $path)
export PATH

# plugins
plugins=(
  aws
  brew
  docker
  git
  gnu-utils
  helm
  history
  macos
)

[ -r ~/.zsh_aliases ] && source ~/.zsh_aliases
[[ "$INSIDE_EMACS" = 'vterm' && -r ~/.zsh_vterm ]] && source ~/.zsh_vterm
[ -r ${ZSH}/oh-my-zsh.sh ] && source ${ZSH}/oh-my-zsh.sh
