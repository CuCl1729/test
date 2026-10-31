#> test:research/eval_know_loop
# @s = プレイヤー。research_work.kq(必要な知識 [{el, label, n}])を1件ずつ調べる

execute unless data storage test: research_work.kq[0] run return 0
data modify storage test: research_work.kh set from storage test: research_work.kq[0]
function test:research/eval_know_have with storage test: research_work.kh
function test:research/eval_know_line with storage test: research_work.kh
data remove storage test: research_work.kq[0]
function test:research/eval_know_loop
