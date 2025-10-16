echo "load ${(%):-%N}"
path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
# PATH 追記類（Homebrew の後に）
export PATH="$PATH:/Users/mopipico/.composer/vendor/bin"
export PATH=$PATH:~/Library/Android/sdk/ndk/27.1.12297006/
export PATH="/opt/homebrew/opt/util-linux/bin:$PATH" # GNU cal を使う
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH" # GNU grep に切替（2025/06/24）


# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"


# PlatformIO（pipenv相当の仮想環境）
export PATH="$PATH:/Users/mopipico/.platformio/penv/bin"


# JetBrains
export PATH="$PATH:/Applications/DataGrip.app/Contents/MacOS"
export PATH="$PATH:/Applications/PyCharm.app/Contents/MacOS"
