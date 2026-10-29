#> test:item/pickaxe/give
# @s = 受け取るプレイヤー。@macro id: ツルハシのid。ツルハシを1本作って(test:item/pickaxe/build)インベントリに直接渡す
# (test:item/material/give と同じ渡し方)。定義が無ければ0、渡したら1を返す

scoreboard players set #pickaxe_built test.temporary 0
$execute store result score #pickaxe_built test.temporary run function test:item/pickaxe/build {id:"$(id)"}
execute if score #pickaxe_built test.temporary matches 0 run return 0

data modify storage test: loot.item.count set value 1
execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run loot give @s mine 0 -64 0 debug_stick
return 1
