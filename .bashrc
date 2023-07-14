[ -r /etc/bashrc ] && source /etc/bashrc

# aliases
alias ll='ls -lG --color=auto'
alias wget='curl -kO'

# inside VS Code
if [[ $TERM_PROGRAM == 'vscode' ]]; then
  source "$(code --locate-shell-integration-path bash)"
  alias rg='rg --smart-case --hidden --no-heading --column'
  export EDITOR='code --wait'
  export VISUAL="${EDITOR}"
else
  alias rg='rg --smart-case --hidden'
fi
