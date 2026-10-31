#> test:craft/magic/research/populate_top_slot
# @s = 研究ステーション本体。@macro id/slot: 研究のidと詰め先スロット番号。
# 近くのプレイヤーについて条件を調べ(test:research/eval が research_work.item を作る)、そのアイテムを置く

data modify entity @s data.research_ui.page_ids append value ""
$data modify entity @s data.research_ui.page_ids[-1] set value "$(id)"

$execute as @p[distance=..6] run function test:research/eval {id:"$(id)"}
$data modify storage test: research_work.item.Slot set value $(slot)b
data modify block ~ ~ ~ Items append from storage test: research_work.item
