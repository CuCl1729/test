#> test:debug/give_magic_seeds_loop
# @s = プレイヤー。debug_work.give_queue を1つずつ渡す

execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.give_arg set value {id:"",count:16}
data modify storage test: debug_work.give_arg.id set from storage test: debug_work.give_queue[0]
data remove storage test: debug_work.give_queue[0]
function test:item/magic_seed/give with storage test: debug_work.give_arg
function test:debug/give_magic_seeds_loop
