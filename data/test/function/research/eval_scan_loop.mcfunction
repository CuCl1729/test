#> test:research/eval_scan_loop
# @s = プレイヤー。research_work.q(調べておく観測のid)を1件ずつ調べる

execute unless data storage test: research_work.q[0] run return 0
data modify storage test: research_work.qa set value {id:""}
data modify storage test: research_work.qa.id set from storage test: research_work.q[0]
function test:research/eval_scan with storage test: research_work.qa
data remove storage test: research_work.q[0]
function test:research/eval_scan_loop
