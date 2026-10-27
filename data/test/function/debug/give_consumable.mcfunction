#> test:debug/give_consumable
# @s = プレイヤー。@macro id: 消耗品のid。16個作って渡す(loot.context は呼び出し側が "inventory" にしてある)

scoreboard players set #consumable_built test.temporary 0
$execute store result score #consumable_built test.temporary run function test:item/consumable/build {id:"$(id)"}
execute if score #consumable_built test.temporary matches 1 run data modify storage test: loot.item.count set value 16
execute if score #consumable_built test.temporary matches 1 run function test:loot/give
