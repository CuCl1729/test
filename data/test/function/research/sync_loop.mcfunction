#> test:research/sync_loop
# @s = プレイヤー。research_work.sync_ids を1件ずつ見る

execute unless data storage test: research_work.sync_ids[0] run return 0
data modify storage test: research_work.sa set value {id:""}
data modify storage test: research_work.sa.id set from storage test: research_work.sync_ids[0]
function test:research/sync_one with storage test: research_work.sa
data remove storage test: research_work.sync_ids[0]
function test:research/sync_loop
