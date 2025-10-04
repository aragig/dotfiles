echo "load ${(%):-%N}"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
#setopt INC_APPEND_HISTORY      # 実行ごとに履歴をファイルに追加
#setopt SHARE_HISTORY           # 他セッションと履歴を共有
#setopt HIST_FCNTL_LOCK         # 競合時のロック（zsh 5.8+）
setopt HIST_IGNORE_ALL_DUPS    # 重複コマンドを無視
setopt INC_APPEND_HISTORY_TIME # タイムスタンプ付きで追記
