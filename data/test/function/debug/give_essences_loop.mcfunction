#> test:debug/give_essences_loop
# @s = プレイヤー。debug_work.give_queue(魔法作物のid)を1つずつ、そのエッセンスにして渡す

execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.ess_arg set value {id:""}
data modify storage test: debug_work.ess_arg.id set from storage test: debug_work.give_queue[0]
data remove storage test: debug_work.give_queue[0]
data modify storage test: debug_work.give_arg set value {id:"",count:16}
function test:debug/give_essences_id with storage test: debug_work.ess_arg
function test:item/material/give with storage test: debug_work.give_arg
function test:debug/give_essences_loop
