#> test:research/grant_loop
# research_work.uq(解放 [{kind, id, path}])を1件ずつ記録する

execute unless data storage test: research_work.uq[0] run return 0
function test:research/grant_one with storage test: research_work.uq[0]
data remove storage test: research_work.uq[0]
function test:research/grant_loop
