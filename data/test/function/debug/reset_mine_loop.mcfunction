#> test:debug/reset_mine_loop
# @s = プレイヤー。mine_work.debug_queue の鉱山を順に見て、範囲の中にいる最初の1つを元に戻す

execute unless data storage test: mine_work.debug_queue[0] run return 0
execute if score #mine_found test.temporary matches 1 run return 0

data modify storage test: mine_work.here.id set from storage test: mine_work.debug_queue[0]
data remove storage test: mine_work.debug_queue[0]
function test:debug/reset_mine_check with storage test: mine_work.here

function test:debug/reset_mine_loop
