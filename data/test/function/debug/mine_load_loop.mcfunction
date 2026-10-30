#> test:debug/mine_load_loop
# debug_work.mine_load_queue(asset.mine_ids のコピー)を1つずつ取り、その鉱山の範囲を forceload する(またはやめる)

execute unless data storage test: debug_work.mine_load_queue[0] run return 0

data modify storage test: debug_work.mine_load_arg set value {id:""}
data modify storage test: debug_work.mine_load_arg.id set from storage test: debug_work.mine_load_queue[0]
data remove storage test: debug_work.mine_load_queue[0]
function test:debug/mine_area with storage test: debug_work.mine_load_arg
data modify storage test: debug_work.mine_area.mode set from storage test: debug_work.mine_load_mode
function test:debug/mine_load_area with storage test: debug_work.mine_area

function test:debug/mine_load_loop
