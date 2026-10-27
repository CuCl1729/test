#> test:debug/give_consumables_loop
# @s = プレイヤー。debug_work.give_queue のidの消耗品を1種類ずつ作って渡す

execute unless data storage test: debug_work.give_queue[0] run return 0

data modify storage test: debug_work.give_arg.id set from storage test: debug_work.give_queue[0]
function test:debug/give_consumable with storage test: debug_work.give_arg

data remove storage test: debug_work.give_queue[0]
function test:debug/give_consumables_loop
