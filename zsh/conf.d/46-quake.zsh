echo "load ${(%):-%N}"

# 地震情報（直近1週間分）
quake() {
  curl -s "https://www.jma.go.jp/bosai/quake/data/list.json" \
  | jq -r '
    ["日時","震源地","M","最大震度"],
    (
      .[]
      | select((.anm // "") != "")
      | (.at | sub("\\+09:00$"; "") | strptime("%Y-%m-%dT%H:%M:%S")) as $ts
      | select(($ts | mktime) >= (now - 7*24*60*60))
      | [
          ($ts | strftime("%Y-%m-%d %H:%M")),
          .anm,
          (.mag // "-"),
          (.maxi // "-")
        ]
    )
    | @tsv
  ' \
  | column -t -s $'\t'
}
