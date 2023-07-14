# Windows Powerline theme, from https://github.com/diesire/git_bash_windows_powerline
# Requires a Powerline-patched font, such as Iosevka. Under Windows 10, set
# terminal.integrated.shellIntegration.enabled to false in
# ~/AppData/Roaming/Code/User/settings.json for the following to work under
# Windows Terminal.
[ -r "${HOME}/.bash/themes/git_bash_windows_powerline/theme.bash" ] && source "${HOME}/.bash/themes/git_bash_windows_powerline/theme.bash"

GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
COMPLETION_PATH="${COMPLETION_PATH}/share/git/completion"

[ -r "${COMPLETION_PATH}/git-completion.bash" ] && source "${COMPLETION_PATH}/git-completion.bash"
