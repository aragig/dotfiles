" ========== 文字コード/改行コード ==========
set encoding=utf-8              " Vim内部の文字コード
scriptencoding utf-8            " このvimrcファイル自体の文字コード
set fileencodings=utf-8,cp932,sjis,utf-16le,euc-jp,latin1
                                " 既存ファイルを開く際の自動判定の優先順
set fileformats=unix,dos        " 改行コードの判定順（LF優先, CRLFも許可）
set ambiwidth=double            " ①のような文字が全角で表示されるように

execute pathogen#infect()
execute pathogen#helptags()

" ========== 表示/操作まわり ==========
syntax enable                   " 構文ハイライトを有効化
"colorscheme iceberg            " 任意の配色（未使用）
"colorscheme slate               " 標準の“slate”配色を使用
set t_Co=256
set background=light
" colorscheme lucius
colorscheme PaperColor

set colorcolumn=100              " 折り返し目安の縦線（ルーラー）
set laststatus=2                " 常にステータスラインを表示
set ruler                       " 画面右下にカーソル位置を表示
set showmode                    " 現在のモードを表示
set showcmd                     " 入力中のコマンドを表示
set number                      " 行番号を表示
set hidden                      " 未保存でもバッファ切替を許可
set wildmenu                    " コマンドライン補完をポップアップ風に
set iminsert=0                  " 挿入モード開始時はIMEオフ
set hlsearch                    " 検索結果をハイライト
set autoindent                  " 自動インデントを有効化
set shortmess-=S                " 検索結果の件数表示

" ========== ファイル保存/バックアップ ==========
set noundofile                  " 永続Undoファイルを作らない
set backup                      " 上書き時にバックアップを作成
set noswapfile                  " スワップファイルを作らない
set backupdir=/tmp              " バックアップファイルの保存先

" ========== インデント/タブ幅 ==========
set noexpandtab                 " タブ文字をそのまま挿入
set tabstop=2                   " タブ幅の見た目を2に
set shiftwidth=2                " 自動インデント幅も2に

" ========== ファイルタイプ別設定 ==========
augroup vimrc
  autocmd!
  autocmd FileType vim setlocal keywordprg=:help
  " vimスクリプト内でKキー（キーワードヘルプ）を:helpに割り当て
augroup END

nnoremap <Leader>ev :e ~/dotfiles/.vimrc<CR>
nnoremap <Leader>cv :e ~/dotfiles/cheatsheets/vim.txt<CR>


" ========= チェックボックス挿入 =========
nnoremap <Leader>b :normal! I[ ] <CR>

" ========= vim-commentary コメントアウト設定 =========
filetype plugin indent on
autocmd FileType vim setlocal commentstring=\"\ %s

" Yazi風に qq で終了
nnoremap <silent> qq :q<CR>

