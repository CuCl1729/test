#> test:quest/list_loop
# @s = プレイヤー。quest_work.lq(asset.quest_ids のコピー)を1件ずつ、受けていれば出す

execute unless data storage test: quest_work.lq[0] run return 0
data modify storage test: quest_work.la set value {id:""}
data modify storage test: quest_work.la.id set from storage test: quest_work.lq[0]
data remove storage test: quest_work.lq[0]
function test:quest/list_one with storage test: quest_work.la
function test:quest/list_loop
