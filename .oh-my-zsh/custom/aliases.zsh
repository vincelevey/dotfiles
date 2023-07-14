# aliases for macOS
preman() {
  mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
}
alias man=preman

alias cal='ncal -w'
alias ci='vi'
#alias df='gdf'
#alias du='gdu'
alias eject='drutil eject'
alias diff='diff --color -u'
#alias gdiff='opendiff'
alias j='jobs -l'
alias ldd='otool -L'
alias ll='ls -lG'
alias locate='mdfind -name'
alias psu='ps u'
alias pwd='echo $PWD'
alias rm='rm -i'
#alias wget='curl -O'

