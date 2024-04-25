# ssh-agent
AGENT_ENV=~/.ssh/agent.env

function agent_load_env () {
  test -r "${AGENT_ENV}" && source "${AGENT_ENV}" >/dev/null
}

function agent_start () {
  (umask 077; ssh-agent >| "${AGENT_ENV}")
  source "${AGENT_ENV}" >/dev/null
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >/dev/null 2>&1; echo $?)

if [ ! "${SSH_AUTH_SOCK}" ] || [ $agent_run_state = 2 ]; then
  agent_start
  ssh-add
elif [ "${SSH_AUTH_SOCK}" ] && [ $agent_run_state = 1 ]; then
  ssh-add
fi
unset AGENT_ENV

# ssh completion
function _ssh () {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  if [ "${cur:0:1}" != "-" ]; then
    COMPREPLY=( $(awk '/^Host '$2'/ {print $2}' ~/.ssh/config) )
  fi
  return 0
}
complete -F _ssh ssh

# path management
# This function is usually present under Linux but missing under Git Bash.
function pathmunge () {
  case ":${PATH}:" in
    *:"${1}":*)
      ;;
    *)
      if [ $2 = 'after' ]; then
        PATH="${PATH}:${1}"
      else
        PATH="${1}:${PATH}"
      fi
      ;;
  esac
}

[ -r ~/.bashrc ] && source ~/.bashrc

# add MSYS2 path, for locally installed tools like jq
[ -d /c/msys64/mingw64/bin ] && pathmunge /c/msys64/mingw64/bin

# Node.js
[ -d "/c/Program Files/nodejs" ] && pathmunge "/c/Program Files/nodejs" after
[ -d "${HOME}/AppData/Roaming/npm" ] && pathmunge "${HOME}/AppData/Roaming/npm" after

# Python
# Generally, it's better to use the Windows py command for Python invocation,
# however applications such as the AWS CDK require Python and associated
# binaries to be in the path.
if [ -d "/c/Program Files/Python312/Scripts" ]; then
  pathmunge "/c/Program Files/Python312" after
  pathmunge "/c/Program Files/Python312/Scripts" after
fi
[ -d "${HOME}/AppData/Roaming/Python/Python312/Scripts" ] && pathmunge "${HOME}/AppData/Roaming/Python/Python312/Scripts" after

# cert for iBoss web proxy (required after November 2022)
#export REQUESTS_CA_BUNDLE="/c/Program Files/Phantom/IBSA/mitm-ca-root-update.crt"

# AWS (requires corporate cert bundle)
[ -r "/c/Program Files/Certificate Bundle/tls-ca-bundle.pem" ] && export AWS_CA_BUNDLE="/c/Program Files/Certificate Bundle/tls-ca-bundle.pem"

# GitHub CLI
[ -d "/c/Program Files (x86)/GitHub CLI" ] && pathmunge "/c/Program Files (x86)/GitHub CLI" after

# environment variables
HTTP_PROXY='http://proxy-server:8080'
HTTPS_PROXY=$HTTP_PROXY
http_proxy=$HTTP_PROXY
https_proxy=$HTTP_PROXY
ftp_proxy=$HTTP_PROXY
rsync_proxy=$HTTP_PROXY
no_proxy='*.domain'
export HTTP_PROXY HTTPS_PROXY http_proxy https_proxy ftp_proxy rsync_proxy no_proxy
export PATH
