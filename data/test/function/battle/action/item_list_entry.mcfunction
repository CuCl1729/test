#> test:battle/action/item_list_entry
# @s = プレイヤー。@macro id: 消耗品のid。持っていれば battle.temporary.item_slot に {id, count} を足す

scoreboard players set #item_count test.temporary 0
$execute store result score #item_count test.temporary run clear @s *[custom_data~{test:{consumable:"$(id)"}}] 0
execute if score #item_count test.temporary matches 0 run return 0

$data modify storage test: battle.temporary.item_slot append value {id:"$(id)",count:0}
execute store result storage test: battle.temporary.item_slot[-1].count int 1 run scoreboard players get #item_count test.temporary
scoreboard players add #item_slot test.temporary 1
