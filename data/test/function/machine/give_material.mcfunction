#> test:machine/give_material
# @macro id: 素材のid。#machine_give_count 個の素材を作って(test:item/material/build)、出すもの(machine_work.drop)に足す

scoreboard players set #machine_built test.temporary 0
$execute store result score #machine_built test.temporary run function test:item/material/build {id:"$(id)"}
$execute if score #machine_built test.temporary matches 0 run return run function test:debug/log {msg:"機械: 素材「$(id)」がありません"}
execute store result storage test: loot.item.count int 1 run scoreboard players get #machine_give_count test.temporary
data modify storage test: machine_work.drop append from storage test: loot.item
