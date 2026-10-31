#> test:debug/give_gather_tools_loop
# @s = プレイヤー。debug_work.give_queue を1つずつ渡す

execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.give_arg set value {id:""}
data modify storage test: debug_work.give_arg.id set from storage test: debug_work.give_queue[0]
data remove storage test: debug_work.give_queue[0]
function test:item/gather_tool/give with storage test: debug_work.give_arg
function test:debug/give_gather_tools_loop
