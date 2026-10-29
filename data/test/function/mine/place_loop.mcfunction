#> test:mine/place_loop
# @macro dim: マップ(action / turn)。mine_work.struct_queue({id,x,y,z}の一覧)の構造物を1つずつ置く

execute unless data storage test: mine_work.struct_queue[0] run return 0

data modify storage test: mine_work.struct_arg set from storage test: mine_work.struct_queue[0]
$data modify storage test: mine_work.struct_arg.dim set value "$(dim)"
data remove storage test: mine_work.struct_queue[0]
function test:mine/place_one with storage test: mine_work.struct_arg

$function test:mine/place_loop {dim:"$(dim)"}
