#> test:debug/mine_status_loop
# @s = プレイヤー。mine_work.debug_queue の鉱山を1つずつ、action と turn の2行で出す

execute unless data storage test: mine_work.debug_queue[0] run return 0

data modify storage test: mine_work.status_arg set value {id:"",dim:"action"}
data modify storage test: mine_work.status_arg.id set from storage test: mine_work.debug_queue[0]
data remove storage test: mine_work.debug_queue[0]
function test:debug/mine_status_line with storage test: mine_work.status_arg
data modify storage test: mine_work.status_arg.dim set value "turn"
function test:debug/mine_status_line with storage test: mine_work.status_arg

function test:debug/mine_status_loop
