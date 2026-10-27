#> test:station/next_mode
# @s = ステーションのマーカー(実行位置は樽)。スロット20のボタンが取られたので、次のモードに切り替える。
# 樽の中にプレイヤーの物(UIアイテム以外)が残っているときは切り替えない
# (例: 付与モードで置いた魔法が、強化モードで強化の素材として使われてしまうのを防ぐ)

# 作業用の定義(station_work)は他のステーションと共有なので、このステーションのものを読み直す
function test:station/enter_mode_def with entity @s data.station

execute store result score #station_all test.temporary if data block ~ ~ ~ Items[]
scoreboard players set #station_ui test.temporary 0
execute store result score #station_n test.temporary if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{station_ui:1b}}}}]
scoreboard players operation #station_ui test.temporary += #station_n test.temporary
execute store result score #station_n test.temporary if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{button:1b}}}}]
scoreboard players operation #station_ui test.temporary += #station_n test.temporary
execute store result score #station_n test.temporary if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{crafter_ui:1b}}}}]
scoreboard players operation #station_ui test.temporary += #station_n test.temporary
execute store result score #station_n test.temporary if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{test:{job_ui:1b}}}}]
scoreboard players operation #station_ui test.temporary += #station_n test.temporary

execute if score #station_all test.temporary > #station_ui test.temporary run tellraw @a[distance=..6] {text:"中の物を取り出してから、モードを切り替えてください",color:"red"}
execute if score #station_all test.temporary > #station_ui test.temporary run return run function test:station/mode_button with storage test: station_work.arg

execute store result score #station_next test.temporary run data get entity @s data.station.mode
scoreboard players add #station_next test.temporary 1
execute if score #station_next test.temporary >= #station_modes test.temporary run scoreboard players set #station_next test.temporary 0
execute store result entity @s data.station.mode int 1 run scoreboard players get #station_next test.temporary

function test:station/enter_mode
