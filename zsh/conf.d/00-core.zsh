echo "load ${(%):-%N}"
# --- colors と prompt 展開を有効化（これが無いと色が出ない）---
autoload -U colors; colors
setopt promptsubst

reload() {
  echo "Reloading Zsh..."
  exec zsh
}
alias src='reload'

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"
