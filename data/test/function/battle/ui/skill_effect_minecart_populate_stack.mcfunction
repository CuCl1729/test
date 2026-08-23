#> test:battle/ui/skill_effect_minecart_populate_stack
# @macro id/label/item/slot: レジストリの1件ぶんと詰め先スロット番号
# 重ねがけ式の効果を「×N」表記で詰める(#selectが現在の段数)
# アイテム名は文字列なのでスコアを直接埋め込めず、段数ごとに分岐して書く

$execute if score #select test.temporary matches 1 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[有効] $(label) ×1",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"$(id)"}}}}
$execute if score #select test.temporary matches 2 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[有効] $(label) ×2",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"$(id)"}}}}
$execute if score #select test.temporary matches 3.. run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[有効] $(label) ×3",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"$(id)"}}}}
