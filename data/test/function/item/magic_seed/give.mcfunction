#> test:item/magic_seed/give
# @s = 受け取るプレイヤー。@macro id/count: 魔法作物のidと個数。種を作ってインベントリに直接渡す(test:item/material/give と同じ)

scoreboard players set #seed_built test.temporary 0
$execute store result score #seed_built test.temporary run function test:item/magic_seed/build {id:"$(id)"}
execute if score #seed_built test.temporary matches 0 run return 0
$data modify storage test: loot.item.count set value $(count)
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
return 1
