[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf: ファイル検索のデフォルトコマンドを fd に置き換え
# fd は .gitignore を自動で尊重し、隠しファイルも扱える
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow \
	--exclude .git --exclude .Trash \
	--exclude node_modules --exclude .composer \
	--exclude .zsh_sessions --exclude .android \
	--exclude .rbenv --exclude .cocoapods \
	--exclude .swiftpm --exclude .konan \
	--exclude .m2 --exclude go \
	--exclude .rustup --exclude .npm \
	--exclude .nvm --exclude .platformio \
	--exclude .cargo --exclude .local \
	--exclude AndroidStudioProjects --exclude Sites \
	--exclude Library --exclude DataGripProjects \
	--exclude .gradle --exclude cache \
	--exclude .cache --exclude Library/Caches'

# Ctrl-T などのfzf補完にも同じ設定を適用
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# プレビュー（bat があれば）
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always --line-range :300 {} 2>/dev/null || tail -n 300 {}"'

