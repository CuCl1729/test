#> test:machine/shape/casing_find_loop
# 実行位置 = 筐体のブロック。machine_work.casing_queue を1つずつ試し、見つかったら終える

execute unless data storage test: machine_work.casing_queue[0] run return 0
data modify storage test: machine_work.casing_arg set value {id:""}
data modify storage test: machine_work.casing_arg.id set from storage test: machine_work.casing_queue[0]
data remove storage test: machine_work.casing_queue[0]
function test:machine/shape/casing_try with storage test: machine_work.casing_arg
execute unless data storage test: machine_work{casing:""} run return 0
function test:machine/shape/casing_find_loop
