#> test:magic/crafter/populate_build
# @s = クラフター本体(barrelの位置)。data.crafter_ui.build のうち、中段のページ bpage(9件ずつ、最大3ページ)の分を
# スロット9〜17へ描画し直し、出した id の並びを data.crafter_ui.view に控える(test:magic/crafter/main がクリックの検知に使う)。
# 下段のページ送り(19=前 / 20はモード / 21=次)と固定ボタン(18=全て消去 / 26=クラフト)もあわせて置き直す
# (どれもクリックで取られると空になり、次に検知されたクリックを毎tick誤検知し続けてしまうため、
#  状態が変わるたびに必ずここで置き直す)

# ページを範囲に収める(最後のページ = (件数 − 1) ÷ 9。要素を消して空になったページや、追加時の 99 を直す)
execute store result score #b_len test.buff.work run data get entity @s data.crafter_ui.build
scoreboard players operation #b_last test.buff.work = #b_len test.buff.work
scoreboard players remove #b_last test.buff.work 1
scoreboard players operation #b_last test.buff.work /= #9 test.constant
execute if score #b_last test.buff.work matches ..-1 run scoreboard players set #b_last test.buff.work 0
scoreboard players set #b_page test.buff.work 0
execute store result score #b_page test.buff.work run data get entity @s data.crafter_ui.bpage
execute if score #b_page test.buff.work > #b_last test.buff.work run scoreboard players operation #b_page test.buff.work = #b_last test.buff.work
execute if score #b_page test.buff.work matches ..-1 run scoreboard players set #b_page test.buff.work 0
execute store result entity @s data.crafter_ui.bpage int 1 run scoreboard players get #b_page test.buff.work

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
scoreboard players operation #b_skip test.buff.work = #b_page test.buff.work
scoreboard players operation #b_skip test.buff.work *= #9 test.constant
function test:magic/crafter/populate_build_skip
data modify entity @s data.crafter_ui.view set value []
scoreboard players set #build_slot test.buff.work 9
function test:magic/crafter/populate_build_loop

# 中段のページ送り(出していない矢印は検知しない: bprev / bnext)
data remove block ~ ~ ~ Items[{Slot:19b}]
data remove block ~ ~ ~ Items[{Slot:21b}]
data modify entity @s data.crafter_ui.bprev set value 0b
data modify entity @s data.crafter_ui.bnext set value 0b
execute if score #b_page test.buff.work matches 1.. run data modify entity @s data.crafter_ui.bprev set value 1b
execute if score #b_page test.buff.work < #b_last test.buff.work run data modify entity @s data.crafter_ui.bnext set value 1b
execute if score #b_page test.buff.work matches 1.. run data modify block ~ ~ ~ Items append value {Slot:19b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前の要素",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
execute if score #b_page test.buff.work < #b_last test.buff.work run data modify block ~ ~ ~ Items append value {Slot:21b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"次の要素 ▶",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}

data remove block ~ ~ ~ Items[{Slot:18b}]
data modify block ~ ~ ~ Items append value {Slot:18b,id:"barrier",count:1,components:{"minecraft:custom_name":{text:"全て消去",italic:false,color:"red"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
data remove block ~ ~ ~ Items[{Slot:26b}]
data modify block ~ ~ ~ Items append value {Slot:26b,id:"nether_star",count:1,components:{"minecraft:custom_name":{text:"クラフトする",italic:false,color:"green"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
