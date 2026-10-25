#> test:craft/equip/craft
# @s = 防具工房マーカー。スロット9の素材(kind)でシリーズ、スロット10の型紙(part)で部位を決めて作る。
# スロット9の個数でレア度が決まる(鍛冶場と同じ: 5〜9個=3、10〜19個=4、20個以上=5)。
# 素材は使い切り、型紙は何度でも使えるよう消費しない

data remove storage test: loot.item
data remove storage test: loot.rare

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind run return 0
execute unless data block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.pattern.part run return 0

scoreboard players set #forge_count test.temporary 0
execute store result score #forge_count test.temporary run data get block ~ ~ ~ Items[{Slot:9b}].count

execute if score #forge_count test.temporary matches 5..9 run data modify storage test: loot.rare set value 3
execute if score #forge_count test.temporary matches 10..19 run data modify storage test: loot.rare set value 4
execute if score #forge_count test.temporary matches 20.. run data modify storage test: loot.rare set value 5

data modify storage test: loot.equip_material set from block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.material.kind
data modify storage test: loot.equip_part set from block ~ ~ ~ Items[{Slot:10b}].components."minecraft:custom_data".test.pattern.part

function test:craft/equip/recipe with storage test: loot

# 何か作れたときだけ素材を消費する(レシピの無い素材を入れても失われないように)
execute if data storage test: loot.item run data remove block ~ ~ ~ Items[{Slot:9b}]
