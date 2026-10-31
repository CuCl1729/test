#> test:craft/magic/research/populate_top
# @s = 研究ステーション本体(barrelの位置)。data.research_ui.page に応じた研究の項目(asset.research_ids)7件をスロット1〜7へ、
# 矢印をスロット0/8へ、自分の知識の量をスロット13へ描画する。各項目は近くのプレイヤーの状態(済・研究できる・足りない)で色を変える

# 先に、習得済みの魔法要素を解放する研究を済にしておく(研究を入れる前に習得した人のため)。oh_my_dat はこのプレイヤーを指したままになる
execute as @p[distance=..6] run function test:research/sync_known

data modify storage test: registry_work.top_known set from storage test: asset.research_ids

# data.research_ui.page は「ページ番号」ではなく「先頭から読み飛ばす件数」そのものを持つ
# (普通クリックで1、Shiftクリック相当で7ずつ動く。test:craft/magic/research/click_arrow参照)
scoreboard players set #top_skip test.buff.work 0
execute store result score #top_skip test.buff.work run data get entity @s data.research_ui.page
function test:magic/crafter/populate_top_skip

data remove block ~ ~ ~ Items[{Slot:0b}]
data remove block ~ ~ ~ Items[{Slot:1b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:3b}]
data remove block ~ ~ ~ Items[{Slot:4b}]
data remove block ~ ~ ~ Items[{Slot:5b}]
data remove block ~ ~ ~ Items[{Slot:6b}]
data remove block ~ ~ ~ Items[{Slot:7b}]
data remove block ~ ~ ~ Items[{Slot:8b}]
data remove block ~ ~ ~ Items[{Slot:13b}]

data modify entity @s data.research_ui.page_ids set value []
scoreboard players set #top_slot test.buff.work 1
function test:craft/magic/research/populate_top_slot_loop

data modify entity @s data.research_ui.has_next set value 0b
execute unless entity @s[nbt={data:{research_ui:{page:0}}}] run data modify block ~ ~ ~ Items append value {Slot:0b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前のページ",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
execute if data storage test: registry_work.top_known[0] run data modify entity @s data.research_ui.has_next set value 1b
execute if data storage test: registry_work.top_known[0] run data modify block ~ ~ ~ Items append value {Slot:8b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"次のページ ▶",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}

execute as @p[distance=..6] run function test:research/knowledge_lore
data modify block ~ ~ ~ Items append value {Slot:13b,id:"book",count:1,components:{"minecraft:custom_name":{text:"知識",italic:false,color:"gold"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
data modify block ~ ~ ~ Items[{Slot:13b}].components."minecraft:lore" set from storage test: research_work.klore
