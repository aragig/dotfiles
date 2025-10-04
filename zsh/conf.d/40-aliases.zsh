echo "load ${(%):-%N}"

alias pbc="pbcopy"
alias pbp="pbpaste"
alias te='open -a TextEdit'

# GNU coreutils / bat
alias ls='gls --color -h --group-directories-first -F'
alias cat='bat --paging never --decorations never --plain'

# 誤爆防止（rm を封印）
alias rm='echo "This is not the command you are looking for."; false'

# メディア・画像
alias heic='for file in *.[hH][eE][iI][cC]; do magick "$file" -quality 80 -define jpeg:extent=2MB "${file%.*}.jpg"; done'
alias webp='for file in *.webp; do sips -s format jpeg "$file" --out "${file%.webp}.jpg"; done'

# Python venv
alias venv='source .venv/bin/activate'

# iOS シミュレータ
alias iphone='xcrun simctl boot "iPhone SE (3rd generation)" && open -a Simulator'

# ssg-neo 実行
alias ssg='(cd ~/Projects/ssg-neo && \
export JAVA_HOME=$(/usr/libexec/java_home -v 17) && \
./gradlew -Dorg.gradle.java.home="$JAVA_HOME" bootRun \
--args="generateHtml" \
-Dspring.devtools.restart.enabled=false)'

# PDF 圧縮
alias pdfmin='f(){ input="$1"; output="${input%.*}_min.pdf"; gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input" && echo "$output"; }; f'

# 祝日付き 3ヶ月カレンダー
alias cal3="cal -3; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"\$(date -v-1m '+%Y/%-m/')|\$(date '+%Y/%-m/')|\$(date -v+1m '+%Y/%-m/')\""

# MacVim を既存ウィンドウにタブ追加（--remote-tab-silent）
alias vim='mvim --remote-tab-silent'

# パスワードジェネレータ
alias genhex="openssl rand -hex 32"
alias genpass="LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32; echo"

