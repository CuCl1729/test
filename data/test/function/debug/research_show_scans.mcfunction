#> test:debug/research_show_scans
# @s = プレイヤー。debug_work.give_queue(asset.scan_ids のコピー)を1件ずつ、調べ済みなら名前を出す

execute unless data storage test: debug_work.give_queue[0] run return 0
data modify storage test: debug_work.sa set value {id:""}
data modify storage test: debug_work.sa.id set from storage test: debug_work.give_queue[0]
function test:debug/research_show_scan with storage test: debug_work.sa
data remove storage test: debug_work.give_queue[0]
function test:debug/research_show_scans
