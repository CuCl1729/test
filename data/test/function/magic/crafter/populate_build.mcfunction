#> test:magic/crafter/populate_build
# @s = クラフター本体(barrelの位置)。data.crafter_ui.build の内容をスロット9〜17へ描画し直し、
# 下段の固定ボタン(18=全て消去/26=クラフト)もあわせて置き直す
# (どちらもクリックで取られると空になり、次に検知されたクリックを毎tick誤検知し続けてしまうため、
#  状態が変わるたびに必ずここで置き直す)

data remove block ~ ~ ~ Items[{Slot:9b}]
data remove block ~ ~ ~ Items[{Slot:10b}]
data remove block ~ ~ ~ Items[{Slot:11b}]
data remove block ~ ~ ~ Items[{Slot:12b}]
data remove block ~ ~ ~ Items[{Slot:13b}]
data remove block ~ ~ ~ Items[{Slot:14b}]
data remove block ~ ~ ~ Items[{Slot:15b}]
data remove block ~ ~ ~ Items[{Slot:16b}]
data remove block ~ ~ ~ Items[{Slot:17b}]

data modify storage test: registry_work.build_render_queue set value []
execute if data entity @s data.crafter_ui.build[0] run data modify storage test: registry_work.build_render_queue set from entity @s data.crafter_ui.build

scoreboard players set #build_slot test.buff.work 9
function test:magic/crafter/populate_build_loop

data remove block ~ ~ ~ Items[{Slot:18b}]
data modify block ~ ~ ~ Items append value {Slot:18b,id:"barrier",count:1,components:{"minecraft:custom_name":{text:"全て消去",italic:false,color:"red"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}

data remove block ~ ~ ~ Items[{Slot:26b}]
data modify block ~ ~ ~ Items append value {Slot:26b,id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"クラフトする",italic:false,color:"green"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
