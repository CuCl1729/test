#> test:battle/ui/skill_type_minecart_populate_slot
# @s = タイプ選択中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# @macro id/label/item/slot: レジストリの1件ぶんと詰め先スロット番号
# 習得済みのタイプだけを詰め、詰めたらスロット番号を進める(習得していないタイプは飛ばす)

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run return 0

# 取られたスロットからタイプidを引けるようにしておく
$data modify storage test: battle.temporary.type_slot append value "$(id)"

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(id):1b} run data modify entity @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[有効] $(label)",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_choice:"$(id)"}}}}
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(id):1b} run data modify entity @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[無効] $(label)",italic:false},"minecraft:custom_data":{test:{skill_choice:"$(id)"}}}}

scoreboard players add #type_slot test.temporary 1
