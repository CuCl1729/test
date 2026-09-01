#> test:magic/crafter/populate_top
# @s = クラフター本体(barrelの位置)。data.crafter_ui.page に応じた7件をスロット1〜7へ、
# 矢印をスロット0/8へ描画する。習得済みの要素(タイプ+効果を結合)だけを対象にする

execute as @p[distance=..6] run function #oh_my_dat:please

data modify storage test: registry_work.combined set from storage test: asset.magic.types
data modify storage test: registry_work.combined append from storage test: asset.magic.effects[]

# 登録順を保ったまま習得済みだけへ絞り込む(レジストリ走査と同じ要領で一度反転してから処理する。
# test:magic/registry/reverse_loop は[-1]から取り出して積み直すことで順序を反転させる)
data modify storage test: registry_work.reverse_src set from storage test: registry_work.combined
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop

data modify storage test: registry_work.top_known set value []
function test:magic/crafter/populate_top_filter_loop

# data.crafter_ui.page は「ページ番号」ではなく「先頭から読み飛ばす件数」そのものを持つ
# (普通クリックで1、Shiftクリック相当で7ずつ動く。test:magic/crafter/click_arrow参照)
scoreboard players set #top_skip test.buff.work 0
execute store result score #top_skip test.buff.work run data get entity @s data.crafter_ui.page
function test:magic/crafter/populate_top_skip

# 上段(スロット0〜8)をクリアしてから、残りの先頭7件をスロット1〜7へ詰める
data remove block ~ ~ ~ Items[{Slot:0b}]
data remove block ~ ~ ~ Items[{Slot:1b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:3b}]
data remove block ~ ~ ~ Items[{Slot:4b}]
data remove block ~ ~ ~ Items[{Slot:5b}]
data remove block ~ ~ ~ Items[{Slot:6b}]
data remove block ~ ~ ~ Items[{Slot:7b}]
data remove block ~ ~ ~ Items[{Slot:8b}]

data modify entity @s data.crafter_ui.page_ids set value []
scoreboard players set #top_slot test.buff.work 1
function test:magic/crafter/populate_top_slot_loop

# 矢印(0=先頭ページでなければ表示 / 8=まだ続きがあれば表示)。has_nextは次tickの
# クリック検知(データが無いページ送りとの区別)に使うのでここで確定させておく
data modify entity @s data.crafter_ui.has_next set value 0b
execute unless entity @s[nbt={data:{crafter_ui:{page:0}}}] run data modify block ~ ~ ~ Items append value {Slot:0b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前のページ",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
execute if data storage test: registry_work.top_known[0] run data modify entity @s data.crafter_ui.has_next set value 1b
execute if data storage test: registry_work.top_known[0] run data modify block ~ ~ ~ Items append value {Slot:8b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"次のページ ▶",italic:false},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
