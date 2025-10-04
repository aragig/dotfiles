echo "load ${(%):-%N}"
# Homebrew の PATH などを事前に通す（存在すれば）
#if command -v brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
#fi

