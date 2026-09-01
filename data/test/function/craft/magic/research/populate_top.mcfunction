#> test:craft/magic/research/populate_top
# @s = 研究ステーション本体(barrelの位置)。data.research_ui.page に応じた7件をスロット1〜7へ、
# 矢印をスロット0/8へ描画する。習得済みかどうかを問わず全要素(タイプ+効果)を対象にする
# (魔法クラフター側のtest:magic/crafter/populate_topと同じ骨組みだが、習得済みだけへの絞り込みは
#  行わず、代わりにスロットごとに[済]表記を出す。ページ送りの読み飛ばしはpath非依存なので共用する)

execute as @p[distance=..6] run function #oh_my_dat:please

data modify storage test: registry_work.combined set from storage test: asset.magic.types
data modify storage test: registry_work.combined append from storage test: asset.magic.effects[]

data modify storage test: registry_work.reverse_src set from storage test: registry_work.combined
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop

data modify storage test: registry_work.top_known set value []
function test:craft/magic/research/populate_top_collect_loop

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

data modify entity @s data.research_ui.page_ids set value []
scoreboard players set #top_slot test.buff.work 1
function test:craft/magic/research/populate_top_slot_loop

data modify entity @s data.research_ui.has_next set value 0b
execute unless entity @s[nbt={data:{research_ui:{page:0}}}] run data modify block ~ ~ ~ Items append value {Slot:0b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前のページ",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
execute if data storage test: registry_work.top_known[0] run data modify entity @s data.research_ui.has_next set value 1b
execute if data storage test: registry_work.top_known[0] run data modify block ~ ~ ~ Items append value {Slot:8b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"次のページ ▶",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
