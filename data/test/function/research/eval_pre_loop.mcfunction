#> test:research/eval_pre_loop
# @s = プレイヤー。research_work.q(前提の研究のid)を1件ずつ調べる

execute unless data storage test: research_work.q[0] run return 0
data modify storage test: research_work.qa set value {id:""}
data modify storage test: research_work.qa.id set from storage test: research_work.q[0]
function test:research/eval_pre with storage test: research_work.qa
data remove storage test: research_work.q[0]
function test:research/eval_pre_loop
