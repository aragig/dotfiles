echo "load ${(%):-%N}"

video2gif() {
  local input="$1"
  if [[ -z "$input" ]]; then
    echo "usage: video2gif <input-video>"
    return 1
  fi
  if [[ ! -f "$input" ]]; then
    echo "no such file: $input"
    return 1
  fi

  local dir output tmp palette
  dir="$(dirname "$input")"
  output="$dir/anime.gif"
  tmp="$dir/tmp.gif"
  palette="$dir/palette.png"

  # 失敗/中断時も片付ける
  trap 'command \rm -f -- "$palette" "$tmp"' EXIT

  echo "$output"

  # パレット生成
  ffmpeg -y -i "$input" -vf "fps=15,scale=320:-1:flags=lanczos,palettegen" "$palette" || return $?

  # パレット適用して一旦GIF化
  ffmpeg -y -i "$input" -i "$palette" -filter_complex \
    'fps=15,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse' \
    "$tmp" || return $?

  # 仕上げ最適化（gifsicle が無ければそのまま出力）
  if command -v gifsicle >/dev/null 2>&1; then
    gifsicle -O3 --colors=128 --lossy=30 "$tmp" -o "$output" || return $?
  else
    echo "warn: gifsicle not found; output is unoptimized."
    command \mv -f -- "$tmp" "$output"
  fi

  # 明示的に削除（エイリアス無視）
  command \rm -f -- "$palette" "$tmp"
  # trap解除
  trap - EXIT
  return 0
}
