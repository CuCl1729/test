#> test:init/asset/machine/stage_loop
# machine_work.index_queue(asset.machine_ids のコピー)を1つずつ取り、前処理の機械なら asset.ore_stage.s<stage> を作る

execute unless data storage test: machine_work.index_queue[0] run return 0
data modify storage test: machine_work.index_arg set value {id:""}
data modify storage test: machine_work.index_arg.id set from storage test: machine_work.index_queue[0]
data remove storage test: machine_work.index_queue[0]
function test:init/asset/machine/stage_one with storage test: machine_work.index_arg
function test:init/asset/machine/stage_loop
