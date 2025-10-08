# ~/.zshrc か dotfiles の 31-help.zsh などに
h() {
  if [[ -z "$1" ]]; then
    echo "usage: h <command>"
    return 1
  fi

  local name="$1" real="$1" tf
  # 1) zsh の alias を解決（例: ls='gls --color=auto' → real='gls'）
  if alias "$name" >/dev/null 2>&1; then
    real="${aliases[$name]}"     # 例: 'gls --color=auto'
    real="${real%% *}"           # 先頭のコマンド名だけ取り出す
  fi

  # 2) 実体が存在するか（関数/シェル組み込み/外部コマンド）
  if ! command -v -- "$real" >/dev/null 2>&1; then
    echo "h: command not found: $name"
    return 127
  fi

  tf="$(mktemp)"
  {
    # 3) ありがちなヘルプの出し方を総当たりで取得（stderrも拾う）
    "$real" --help 2>&1 || \
    "$real" -h 2>&1 || \
    "$real" help 2>&1 || \
    man "$real" 2>/dev/null | col -bx || \
    help "$real" 2>&1
  } >"$tf"

  if [[ ! -s "$tf" ]]; then
    echo "no help text for: $name"
    rm -f "$tf"
    return 1
  fi

  # 4) fzf でインクリメンタル閲覧（右に全文プレビュー）
  nl -ba "$tf" | fzf \
    --ansi --no-sort --preview "bat -l man --style=plain --color=always $tf || cat $tf" \
    --preview-window=right:70% \
    --bind 'enter:execute-silent(LESS="-R" less '"$tf"')+abort'

  rm -f "$tf"
}

# コマンド名の補完（引数1つ目でコマンド候補が出る）
compdef _command h

# 好みでエイリアス
alias help='h'

