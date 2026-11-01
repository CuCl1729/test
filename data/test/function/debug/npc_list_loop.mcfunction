#> test:debug/npc_list_loop
# @s = プレイヤー。debug_work.give_queue(asset.npc_ids のコピー)を1件ずつ出す

execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.sa set value {id:""}
data modify storage test: debug_work.sa.id set from storage test: debug_work.give_queue[0]
function test:debug/npc_list_line with storage test: debug_work.sa
data remove storage test: debug_work.give_queue[0]
function test:debug/npc_list_loop
