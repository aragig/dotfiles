# 任意の拡張子を一括変換:  ex) changeext txt md
changeext() {
  local from="$1" to="$2"
  if [[ -z "$from" || -z "$to" ]]; then
    echo "Usage: changeext <from> <to>"
    return 1
  fi
  for f in *."$from"; do
    [[ -e "$f" ]] || continue
    mv "$f" "${f%.$from}.$to"
  done
}

# ── 置換リネーム（substring 置換版）────────────────────────────
# 使い方:
#   renstr <from> <to> [--dry-run] [paths...]
# 例:
#   renstr "チートシート" "cheats" -- *.md
#   renstr foo bar --dry-run **/*      # まずは乾燥（ドライ）実行
#
# 挙動:
#  - ファイル名（ベース名）の「from」を全部「to」に置換
#  - 既に同名の宛先がある場合はスキップ
#  - 引数にパスが無いときはカレントの全件(*)を対象
#  - --dry-run で実際には mv せず計画だけ表示
#
function renstr() {
  local from="$1" to="$2"
  if [[ -z "$from" || -z "$to" ]]; then
    print -r -- "usage: renstr <from> <to> [--dry-run] [paths...]"
    return 2
  fi
  shift 2

  local dry=0
  if [[ "$1" == "--dry-run" ]]; then
    dry=1
    shift
  fi

  # 対象リスト
  local items=("$@")
  (( ${#items} == 0 )) && items=( * )

  local f base dir new dest
  for f in "${items[@]}"; do
    [[ -e "$f" ]] || continue
    # ディレクトリも含めてOKにする（必要に応じて -f 判定に変更可能）
    base="${f:t}"           # basename
    dir="${f:h}"            # dirname
    new="${base//${from}/${to}}"

    # 置換が発生しないならスキップ
    [[ "$base" == "$new" ]] && continue

    dest="$dir/$new"
    if [[ -e "$dest" ]]; then
      print -r -- "skip (exists): $dest"
      continue
    fi

    if (( dry )); then
      print -r -- "mv -- '$f' '$dest'"
    else
      mv -- "$f" "$dest"
      print -r -- "renamed: $f -> $dest"
    fi
  done
}

# ショートエイリアス
alias rn='renstr'

