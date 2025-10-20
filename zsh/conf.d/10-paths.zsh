echo "load ${(%):-%N}"
path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
#--- PATH 追記類（Homebrew の後に）

# GNU coreutils を優先
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH" # ls, mvなどGNU版に切り替え（2025/10/21）
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH" # GNU cal を使う
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH" # GNU grep に切替（2025/06/24）


export PATH="$PATH:/Users/mopipico/.composer/vendor/bin"


# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH=$PATH:~/Library/Android/sdk/ndk/27.1.12297006/


# PlatformIO（pipenv相当の仮想環境）
export PATH="$PATH:/Users/mopipico/.platformio/penv/bin"


# JetBrains
export PATH="$PATH:/Applications/DataGrip.app/Contents/MacOS"
export PATH="$PATH:/Applications/PyCharm.app/Contents/MacOS"


# Programing language
eval "$(rbenv init -)"
export ANT_HOME=/usr/local/ant
export PATH=$ANT_HOME/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin # swagコマンドを使うため追加（2025/06/28）

