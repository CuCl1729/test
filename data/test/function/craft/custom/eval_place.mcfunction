#> test:craft/custom/eval_place
# @s = マーカー(実行位置は樽)。材料の枠を判定し、結果の枠を置き直す(前に置いた本物・バリアは、取られていないことを確かめてあるので消してよい)。
# 作れる → 本物(出るものを個数ぶん) / 未研究 → バリア / 当てはまらない → 空

execute as @p[distance=..6] run function #oh_my_dat:please
function test:craft/custom/eval
execute if data entity @s data.crafter.show run data remove block ~ ~ ~ Items[{Slot:16b}]
data remove entity @s data.crafter.show
data remove entity @s data.crafter.real
data modify entity @s data.crafter.grid set from storage test: craft_work.grid
execute if score #cc_ok test.temporary matches 1 run function test:craft/custom/place_out with storage test: craft_work.rec.out
execute if score #cc_ok test.temporary matches 2 run data modify block ~ ~ ~ Items append value {Slot:16b,id:"minecraft:barrier",count:1,components:{"minecraft:custom_name":{text:"未研究",color:"red",italic:false},"minecraft:custom_data":{test:{station_ui:1b}}}}
# 置いたものは、樽が読み直した形(比べるときと同じ形)で記録する
execute if score #cc_ok test.temporary matches 1.. run data modify entity @s data.crafter.show set from block ~ ~ ~ Items[{Slot:16b}]
execute if score #cc_ok test.temporary matches 1.. run data remove entity @s data.crafter.show.Slot
execute if score #cc_ok test.temporary matches 1 run data modify entity @s data.crafter.real set value 1b
execute if score #cc_ok test.temporary matches 1 run data modify entity @s data.crafter.recipe set from storage test: craft_work.match.recipe
