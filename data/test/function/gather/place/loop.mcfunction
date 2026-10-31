#> test:gather/place/loop
# gather_work.queue(asset.gather_point_ids のコピー)を1つずつ取り、両方のマップに置く

execute unless data storage test: gather_work.queue[0] run return 0
data modify storage test: gather_work.arg set value {id:""}
data modify storage test: gather_work.arg.id set from storage test: gather_work.queue[0]
data remove storage test: gather_work.queue[0]
function test:gather/place/point with storage test: gather_work.arg
function test:gather/place/loop
