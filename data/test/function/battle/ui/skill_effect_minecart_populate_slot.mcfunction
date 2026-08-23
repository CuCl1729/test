#> test:battle/ui/skill_effect_minecart_populate_slot
# @s = 効果選択中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# @macro id/label/item/slot: レジストリの1件ぶんと詰め先スロット番号
# maxが2ならON/OFF、3以上なら重ねがけ段階(×1〜)として名前に反映する

# 取られたスロットから効果idを引けるようにしておく
$data modify storage test: battle.temporary.effect_slot append value "$(id)"

scoreboard players set #select test.temporary 0
$execute store result score #select test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(id)

$execute if score #select test.temporary matches 0 run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[無効] $(label)",italic:false},"minecraft:custom_data":{test:{skill_effect:"$(id)"}}}}
$execute if score #select test.temporary matches 1.. if data storage test: asset.magic.effects[{id:"$(id)",max:2}] run data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:$(slot)b,id:"$(item)",count:1,components:{"minecraft:custom_name":{text:"[有効] $(label)",italic:false,color:"green"},"minecraft:custom_data":{test:{skill_effect:"$(id)"}}}}
$execute if score #select test.temporary matches 1.. unless data storage test: asset.magic.effects[{id:"$(id)",max:2}] run function test:battle/ui/skill_effect_minecart_populate_stack with storage test: registry_work.effect_entry

scoreboard players add #effect_slot test.temporary 1
