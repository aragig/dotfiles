echo "load ${(%):-%N}"
eval "$(rbenv init -)"

export ANT_HOME=/usr/local/ant
export PATH=$ANT_HOME/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin # swagコマンドを使うため追加（2025/06/28）
