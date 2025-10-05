# 対話シェル以外では何もしない
[[ -o interactive ]] || return
# conf.d 読み込み
for f in "$ZDOTDIR"/conf.d/*.zsh(.N); do
  source "$f"
done
# ローカル秘密（任意ファイル名）は存在すれば読む
[[ -f "$ZDOTDIR/conf.d/90-secrets.zsh" ]] && source "$ZDOTDIR/conf.d/90-secrets.zsh"
[[ -f "$ZDOTDIR/.zshrc.local"        ]] && source "$ZDOTDIR/.zshrc.local"
if [[ -r "$HOME/Projects/arai-memo/zsh/paths.private.zsh" ]]; then
  source "$HOME/Projects/arai-memo/zsh/paths.private.zsh"
fi
