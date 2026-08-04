#> test:craft/weapon/upgrade/craft
# @s = 強化炉マーカー。スロット9の武器を、スロット10の素材の個数分だけ強化する

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".level run return 0

data remove storage test: loot.item
data modify storage test: loot.item.id set from block ~ ~ ~ Items[{Slot:9b}].id
data modify storage test: loot.item.components set from block ~ ~ ~ Items[{Slot:9b}].components

scoreboard players set #upgrade_count test.temporary 0
execute store result score #upgrade_count test.temporary run data get block ~ ~ ~ Items[{Slot:10b}].count

execute as @p[distance=..6] run function test:craft/weapon/upgrade/apply_levels

data remove block ~ ~ ~ Items[{Slot:9b}]
data remove block ~ ~ ~ Items[{Slot:10b}]
