echo "load ${(%):-%N}"

# カレントディレクトリの総容量と詳細を表示
duse() {
	echo "=== Total ==="
	du -sh .

	echo
	echo "=== Details ==="
	du -sh * | sort -h
}

