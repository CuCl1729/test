# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/generated/config
# 定数(スプレッドシートの「定数」タブ)。asset.config.<キー>
#   turn_time: 手番の制限時間(秒) / turn_warn: 予告を出す残り時間(秒) / enemy_delay: 敵が行動するまで(tick) / accessory_limit: 効くアクセサリーの数

data modify storage test: asset.config set value {turn_time:30,turn_warn:10,enemy_delay:20,accessory_limit:2}
