# For dark style
#PROMPT='%K{blue}%F{black}%~%F{black} %k%F{blue}%f$ '
# For light style
PROMPT='%F{blue}%~%f$ '
# Just simple
#PROMPT='%~$ '

#export PATH="$PATH:/Users/mopipico/Projects/ssgen"
export PATH="$PATH:/Users/mopipico/.composer/vendor/bin"
export PATH=$PATH:~/Library/Android/sdk/ndk/27.1.12297006/
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH" # バンドルのcal不具合のため GNU cal を使う

# 20250518 Redmineを動かすために以下を追加
export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH" # GNU版のgrepをインストール（brew install grep）して切り替えた 2025/06/24

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# alias c="pbcopy"
# alias p="pbpaste"
alias l='ls -F'
alias ll='ls -alhSFG'
alias rm='echo "This is not the command you are looking for."; false'
alias cal3="cal -3; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"\$(date -v-1m '+%Y/%-m/')|\$(date '+%Y/%-m/')|\$(date -v+1m '+%Y/%-m/')\""
# alias wx="curl -s 'https://www.jma.go.jp/bosai/forecast/data/forecast/130000.json' \
#   | jq -r '
#     .[0].timeSeries[0] as \$ts0 |
#     .[0].timeSeries[1] as \$ts1 |
#     .[0].timeSeries[2] as \$ts2 |
#     \"地域: \(\$ts0.areas[0].area.name)\n天気: \(\$ts0.areas[0].weathers[0])\n風: \(\$ts0.areas[0].winds[0])\n波: \(\$ts0.areas[0].waves[0] // \"-\")\n降水確率: \(\$ts1.areas[0].pops[0] // \"-\")/\(\$ts1.areas[0].pops[1] // \"-\")/\(\$ts1.areas[0].pops[2] // \"-\")/\(\$ts1.areas[0].pops[3] // \"-\")\n現在気温: \(\$ts2.areas[0].temps[3] // \"-\")℃\n最高気温: \(\$ts2.areas[0].temps[0] // \"-\")℃\n最低気温: \(\$ts2.areas[0].temps[2] // \"-\")℃\"
#   '"
alias heic='for file in *.[hH][eE][iI][cC]; do magick "$file" -quality 80 -define jpeg:extent=2MB "${file%.*}.jpg"; done'
alias webp='for file in *.webp; do sips -s format jpeg "$file" --out "${file%.webp}.jpg"; done'
alias venv='source .venv/bin/activate'
alias iphone='xcrun simctl boot "iPhone SE (3rd generation)" && open -a Simulator'
alias ssg='(cd ~/Projects/ssg-neo && ./gradlew bootRun --args="generateHtml" -Dspring.devtools.restart.enabled=false)'
# PDF圧縮
alias pdfmin='f(){ input="$1"; output="${input%.*}_min.pdf"; gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input" && echo "$output"; }; f'
# 地震情報（直近1週間分）
quake() {
  curl -s "https://www.jma.go.jp/bosai/quake/data/list.json" \
  | jq -r '
    ["日時","震源地","M","最大震度"],
    (
      .[]
      | select((.anm // "") != "")
      | (.at | sub("\\+09:00$"; "") | strptime("%Y-%m-%dT%H:%M:%S")) as $ts
      | select(($ts | mktime) >= (now - 7*24*60*60))
      | [
          ($ts | strftime("%Y-%m-%d %H:%M")),
          .anm,
          (.mag // "-"),
          (.maxi // "-")
        ]
    )
    | @tsv
  ' \
  | column -t -s $'\t'
}

# パスワードジェネレータ（API用）
alias genhex="openssl rand -hex 32"
# パスワードジェネレータ（普段使い用）
alias genpass="LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32; echo"

alias code='subl'


eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
export PATH="$PATH:/Users/mopipico/.platformio/penv/bin"

export ANT_HOME=/usr/local/ant
export PATH=$ANT_HOME/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin # swagコマンドを使うため追加（2025/06/28）

## History with peco!
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# ローカル上書き（非公開）を安全に読込む
for f in ~/.zshrc.local; do
  [ -r "$f" ] && source "$f"
done
