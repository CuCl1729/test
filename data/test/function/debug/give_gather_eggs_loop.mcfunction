#> test:debug/give_gather_eggs_loop
# @s = プレイヤー。debug_work.give_queue を1つずつ渡す
execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.give_arg set value {type:""}
data modify storage test: debug_work.give_arg.type set from storage test: debug_work.give_queue[0]
data remove storage test: debug_work.give_queue[0]
function test:gather/egg/give with storage test: debug_work.give_arg
function test:debug/give_gather_eggs_loop
