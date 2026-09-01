#> test:magic/crafter/populate_top_slot
# @s = クラフター本体。@macro id/label/color/item/slot: レジストリの1件ぶんと詰め先スロット番号
# クリック検知(test:magic/crafter/main)がスロット番号→idを引けるよう、page_idsへも積んでおく
# (スロット1〜7 ↔ page_ids[0]〜[6]。スロット-1した位置に対応する)

data modify entity @s data.crafter_ui.page_ids append value ""
$data modify entity @s data.crafter_ui.page_ids[-1] set value "$(id)"

$data modify block ~ ~ ~ Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"$(label)",italic:false,color:"$(color)"},"minecraft:custom_data":{test:{crafter_ui:1b}}}}
