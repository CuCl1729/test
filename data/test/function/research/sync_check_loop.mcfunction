#> test:research/sync_check_loop
# research_work.sq(解放 [{path, id}])のどれかがまだ記録されていなければ #rs_all = 0

execute unless data storage test: research_work.sq[0] run return 0
function test:research/sync_check with storage test: research_work.sq[0]
data remove storage test: research_work.sq[0]
function test:research/sync_check_loop
