echo "load ${(%):-%N}"

# ごみ箱へ移動（同名があれば連番付与＆効果音）
trash() {
  for f in "$@"; do
    if [ -e "$f" ]; then
      base=$(basename "$f")
      dest="$HOME/.Trash/$base"
      count=1
      while [ -e "$dest" ]; do
        dest="$HOME/.Trash/${base%.*} ($count).${base##*.}"
        count=$((count + 1))
      done
      mv "$f" "$dest"
      echo "Moved $f to Trash as $(basename "$dest")"
      afplay /System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag\ to\ trash.aif
    fi
  done
}
