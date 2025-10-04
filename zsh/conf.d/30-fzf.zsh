[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf: ファイル検索のデフォルトコマンドを fd に置き換え
# fd は .gitignore を自動で尊重し、隠しファイルも扱える
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .Trash'

# Ctrl-T などのfzf補完にも同じ設定を適用
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
