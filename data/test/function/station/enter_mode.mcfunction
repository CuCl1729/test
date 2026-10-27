#> test:station/enter_mode
# @s = ステーションのマーカー(実行位置は樽)。data.station.mode 番目のモードに入る:
# 樽の中のUIアイテムを消し、モードの関数を写し、切り替えボタン・作るボタン・GUIの題名を整えてから、モードの enter を呼ぶ。
# UIアイテムは目印(station_ui / button / crafter_ui / job_ui)の付いた物だけを消す(プレイヤーが置いた物は残す)

data remove block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{station_ui:1b}}}}]
data remove block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{button:1b}}}}]
data remove block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{crafter_ui:1b}}}}]
data remove block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{job_ui:1b}}}}]

execute unless data entity @s data.station.mode run data modify entity @s data.station.mode set value 0
function test:station/enter_mode_def with entity @s data.station

data remove entity @s data.station.main
data remove entity @s data.station.craft
data modify entity @s data.station.main set from storage test: station_work.mode.main
data modify entity @s data.station.craft set from storage test: station_work.mode.craft

# GUIの題名(モードが1つなら名前だけ)
tag @s remove station_multi
execute if score #station_modes test.temporary matches 2.. run tag @s add station_multi
execute if entity @s[tag=station_multi] run function test:station/set_title with storage test: station_work.arg
execute unless entity @s[tag=station_multi] run data modify block ~ ~ ~ CustomName set value {text:""}
execute unless entity @s[tag=station_multi] run data modify block ~ ~ ~ CustomName.text set from storage test: station_work.def.name

# モード切り替えボタン(スロット20。プレイヤーの物が置いてあれば置かない)
execute if entity @s[tag=station_multi] unless data block ~ ~ ~ Items[{Slot:20b}] run function test:station/mode_button with storage test: station_work.arg

# ボタン型のモードは、スロット26に作るボタンを置く
execute if data storage test: station_work.mode.craft run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

execute if data storage test: station_work.mode.enter run function test:station/run_enter with storage test: station_work.mode
