#> test:craft/magic/research/populate_top_slot
# @s = 研究ステーション本体。@macro id/label/color/item/slot: レジストリの1件ぶんと詰め先スロット番号
# 習得済みなら[済]を付けて灰色表示にする(#oh_my_dat:pleaseは呼び出し元で実行済み)

data modify entity @s data.research_ui.page_ids append value ""
$data modify entity @s data.research_ui.page_ids[-1] set value "$(id)"

$execute as @p[distance=..6] run function test:magic/registry/known_check {id:"$(id)"}

$execute if score #known test.temporary matches 0 run data modify block ~ ~ ~ Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"$(label)",italic:false,color:"$(color)"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
$execute if score #known test.temporary matches 1 run data modify block ~ ~ ~ Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[済] $(label)",italic:false,color:"gray"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
