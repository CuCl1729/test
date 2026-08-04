#> test:craft/weapon/upgrade/craft
# @s = 強化炉マーカー。スロット9の武器を、スロット10の素材の個数分だけ強化する。
# 最大レベルまでの残り回数を超える素材は消費せずスロット10に残す

execute unless data block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".level run return 0

data remove storage test: loot.item
data modify storage test: loot.item.id set from block ~ ~ ~ Items[{Slot:9b}].id
data modify storage test: loot.item.components set from block ~ ~ ~ Items[{Slot:9b}].components

execute store result score #cur_level test.temporary run data get storage test: loot.item.components."minecraft:custom_data".level
execute store result score #max_level test.temporary run data get storage test: loot.item.components."minecraft:custom_data".max_level

scoreboard players operation #remaining_level test.temporary = #max_level test.temporary
scoreboard players operation #remaining_level test.temporary -= #cur_level test.temporary
execute if score #remaining_level test.temporary matches ..0 run return 0

scoreboard players set #upgrade_count test.temporary 0
execute store result score #upgrade_count test.temporary run data get block ~ ~ ~ Items[{Slot:10b}].count

execute if score #upgrade_count test.temporary > #remaining_level test.temporary run scoreboard players operation #upgrade_count test.temporary = #remaining_level test.temporary

scoreboard players operation #consumed test.temporary = #upgrade_count test.temporary

function test:craft/weapon/upgrade/apply_levels

function test:loot/give

data remove block ~ ~ ~ Items[{Slot:9b}]

execute store result score #slot10_count test.temporary run data get block ~ ~ ~ Items[{Slot:10b}].count
scoreboard players operation #slot10_count test.temporary -= #consumed test.temporary

execute if score #slot10_count test.temporary matches ..0 run data remove block ~ ~ ~ Items[{Slot:10b}]
execute if score #slot10_count test.temporary matches 1.. store result block ~ ~ ~ Items[{Slot:10b}].count int 1 run scoreboard players get #slot10_count test.temporary
