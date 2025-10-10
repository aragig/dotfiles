echo "load ${(%):-%N}"
# For dark style
# PROMPT='%F{blue}%~%f$ '

function powerline_precmd() {
		PROMPT="$(powerline-shell --shell zsh $?)"$'\n''$ '
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
