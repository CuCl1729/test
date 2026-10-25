#> test:item/weapon/level_up/grow_main
# @macro key: 伸ばすメインステータスのキー(status_bonus / base_status)。
# そのtypeの伸び(loot.table.grow)を、今の値に足して書き戻す(値は×100の整数で計算する)

$data modify storage test: loot.temporary.grow_type set from storage test: loot.item.components."minecraft:custom_data".$(key).type
$execute store result score #grow_cur test.temporary run data get storage test: loot.item.components."minecraft:custom_data".$(key).value 100

function test:item/weapon/level_up/grow_main_add with storage test: loot.temporary

$execute store result storage test: loot.item.components."minecraft:custom_data".$(key).value double 0.01 run scoreboard players get #grow_cur test.temporary
