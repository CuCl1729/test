#> test:magic/crafter/validate_conflict_loop
# conflict_queueを末尾から1件ずつ取り出し、そのタイプも同時に使われていれば組み合わせを不正にする

execute unless data storage test: registry_work.conflict_queue[-1] run return 0

data modify storage test: registry_work.conflict_id set from storage test: registry_work.conflict_queue[-1]
data remove storage test: registry_work.conflict_queue[-1]

function test:magic/crafter/validate_conflict with storage test: registry_work

function test:magic/crafter/validate_conflict_loop
