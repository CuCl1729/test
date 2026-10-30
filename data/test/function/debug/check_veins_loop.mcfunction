#> test:debug/check_veins_loop
# debug_work.check_queue(asset.mine_ids のコピー)を1つずつ取り、その鉱山を調べる

execute unless data storage test: debug_work.check_queue[0] run return 0

data modify storage test: debug_work.check_arg set value {id:""}
data modify storage test: debug_work.check_arg.id set from storage test: debug_work.check_queue[0]
data remove storage test: debug_work.check_queue[0]
function test:debug/check_veins_mine with storage test: debug_work.check_arg

function test:debug/check_veins_loop
