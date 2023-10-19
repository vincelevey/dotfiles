# ssh-agent
AGENT_ENV=~/.ssh/agent.env

agent_load_env () {
  test -r "${AGENT_ENV}" && source "${AGENT_ENV}" >/dev/null
}

agent_start () {
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

[ -r ~/.bashrc ] && source ~/.bashrc

# GitHub CLI
[ -d "/c/Program Files (x86)/GitHub CLI" ] && export PATH="${PATH}:/c/Program Files (x86)/GitHub CLI"

# Python
# don't do this, use the Windows py command instead.
#[ -d "/c/Program Files/Python310" ] && export PATH="/c/Program Files/Python310:${PATH}"

# Node.js
[ -d "/c/Program Files/nodejs" ] && export PATH="/c/Program Files/nodejs:${PATH}"
[ -d "${HOME}/AppData/Roaming/npm" ] && export PATH="${HOME}/AppData/Roaming/npm:${PATH}"

# add MSYS2 path, for locally installed tools like jq
[ -d /c/msys64/mingw64/bin ] && export PATH="${PATH}:/c/msys64/mingw64/bin"

# environment variables
HTTP_PROXY='http://proxy-server:8080'
HTTPS_PROXY=$HTTP_PROXY
http_proxy=$HTTP_PROXY
https_proxy=$HTTP_PROXY
ftp_proxy=$HTTP_PROXY
rsync_proxy=$HTTP_PROXY
no_proxy='*.domain'
export HTTP_PROXY HTTPS_PROXY http_proxy https_proxy ftp_proxy rsync_proxy no_proxy

# cert for iBoss web proxy (required after November 2022)
#export REQUESTS_CA_BUNDLE="/c/Program Files/Phantom/IBSA/mitm-ca-root-update.crt"

# AWS (requires corporate cert bundle)
[ -r "/c/Program Files/Certificate Bundle/tls-ca-bundle.pem" ] && export AWS_CA_BUNDLE="/c/Program Files/Certificate Bundle/tls-ca-bundle.pem"
