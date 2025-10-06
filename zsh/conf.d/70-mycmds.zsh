# conf.d/70-mycmds.zsh などに置いてください
# 一覧: `mycmds`

mycmds() {
  emulate -L zsh
  local dot=${ZDOTDIR:-$HOME}

  # --- Aliases ------------------------------------------------
  print "== Aliases =="
  local -A A; A=(${(kv)aliases})
  for k in ${(ko)A}; do
    # print -r -- "$k => ${A[$k]}"
    print -r -- "$k"
  done
  print

  # --- Functions（自分が定義したものだけ）-------------------
  # 定義元ファイルが $ZDOTDIR または $HOME 配下、もしくは対話定義だけ表示
  print "== Functions (yours) =="
  local -A SRC; SRC=(${(kv)functions_source})
  local listed=0
  for f in ${(ko)functions}; do
    local s=${SRC[$f]}
    [[ -z $s ]] && s="(interactive)"
    if [[ $s == "$dot"/* || $s == "$HOME"/* || $s == "(interactive)" || $s == "(eval)" ]]; then
      ((listed++))
      [[ $s == "$dot"/* ]] && s="${s#$dot/}"   # ZDOTDIR 配下は相対表示
      print -r -- "$f @ $s"
    fi
  done
  (( listed == 0 )) && print "(no user functions found)"
}

