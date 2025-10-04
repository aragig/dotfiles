echo "load ${(%):-%N}"
# For dark style
#PROMPT='%K{blue}%F{black}%~%F{black} %k%F{blue}%f$ '
# For light style
PROMPT='%F{blue}%~%f$ '
# Just simple
#PROMPT='%~$ '

# --- Git ブランチ名を短縮＆状態表示 ---
git_prompt_info() {
  # ブランチ名（HEAD のときは空）
  local raw; raw=$(git branch --show-current 2>/dev/null) || return
  [[ -z $raw ]] && return

  # 末尾2セグメントだけ残す（feature/xxxx/yyyy → xxxx/yyyy）
  local -a segs; segs=(${(s:/:)raw})
  local short; short=$segs[-1]
  (( ${#segs} >= 2 )) && short="${segs[-2]}/${short}"

  # さらに全体を最大28文字に丸める
  local max=28
  (( ${#short} > max )) && short="${short[1,$((max-1))]}…"

  # 変更あり(*) / ステージあり(+) / 未追跡(?)
  local mark=""
  git diff --quiet --ignore-submodules 2>/dev/null || mark="*"
  git diff --cached --quiet 2>/dev/null || mark="${mark}+"
  [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && mark="${mark}?"

  # 色付きで表示（例:  main*,  bugfix/xxx+?）
  print -r " %{$fg_bold[green]%}${short}%{$reset_color%}%{$fg[red]%}${mark}%{$reset_color%}"
}

# --- SSH なら user@host: を付ける ---
ssh_prefix='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:%{$reset_color%}"}'

# --- 実プロンプト（例: user@host: ~/proj/myapp main* %）---
PROMPT=''"$ssh_prefix"'%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) %# '

