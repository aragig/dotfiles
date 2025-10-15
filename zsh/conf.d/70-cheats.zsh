echo "load ${(%):-%N}"
# ===== Cheats unified entrypoints =====
# 検索対象ディレクトリ（順序で優先度を決める）
typeset -ag CHEATS_DIRS
CHEATS_DIRS=(
  "$HOME/dotfiles/cheats"
  "$HOME/memo-arai/cheats"
)

# 依存コマンド
command -v fzf >/dev/null || echo "[cheats] fzf がありません"
command -v rg  >/dev/null || echo "[cheats] ripgrep がありません"
command -v bat >/dev/null || echo "[cheats] bat があるとプレビュー快適です"

# 一覧
clist() {
  local dirs=(
    "$HOME/dotfiles/cheats"
    "$HOME/memo-arai/cheats"
  )
  local IFS=$'\n'
  for d in "${dirs[@]}"; do
    [[ -d $d ]] || continue
    # 絶対パスで .md/.txt を列挙
    find "$d" -type f \( -name '*.md' -o -name '*.txt' \) -print
  done | sort -u
}

# 横断検索＆閲覧（fzf + プレビュー）。Enterで $EDITOR で開く、Ctrl-Oでopen
c() {
  local target
  target=$(
    clist | fzf \
      --prompt="cheats> " \
      --height=80% --border \
      --preview 'if command -v bat >/dev/null 2>&1; then bat --style=plain --paging=never {}; else cat {}; fi' \
      --preview-window=right,60% \
			--bind 'ctrl-o:execute-silent(open {})' \
			--bind 'ctrl-s:execute-silent(subl {})' \
  		--bind 'ctrl-v:execute(bash -lc '"'"'f="$1"; if command -v bat >/dev/null 2>&1; then bat --color=always --style=plain --paging=never "$f"; else cat "$f"; fi | less -R'"'"' -- {})'
  )
  [[ -n $target ]] || return
  "${EDITOR:-vim}" "$target"
}

