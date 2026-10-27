#> test:station/enter_mode_def
# @macro id/mode: ステーションの種類とモード番号。今のモードと次のモードの定義を storage test: station_work に用意する
#   station_work.def:  ステーションの定義
#   station_work.mode: 今のモードの定義
#   station_work.arg:  {name, label, next_label, next_icon}(題名と切り替えボタン用)
#   #station_modes:    モードの数

$data modify storage test: station_work.def set from storage test: asset.station.$(id)
$data modify storage test: station_work.mode set from storage test: asset.station.$(id).modes[$(mode)]
execute store result score #station_modes test.temporary run data get storage test: station_work.def.modes

# 次のモードの番号(最後なら先頭に戻る)
$scoreboard players set #station_next test.temporary $(mode)
scoreboard players add #station_next test.temporary 1
execute if score #station_next test.temporary >= #station_modes test.temporary run scoreboard players set #station_next test.temporary 0
execute store result storage test: station_work.next_index int 1 run scoreboard players get #station_next test.temporary
function test:station/enter_mode_next with storage test: station_work

data modify storage test: station_work.arg set value {}
data modify storage test: station_work.arg.name set from storage test: station_work.def.name
data modify storage test: station_work.arg.label set from storage test: station_work.mode.label
data modify storage test: station_work.arg.next_label set from storage test: station_work.next.label
data modify storage test: station_work.arg.next_icon set from storage test: station_work.next.icon
