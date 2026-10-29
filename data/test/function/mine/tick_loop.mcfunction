#> test:mine/tick_loop
# mine_work.mine_queue(鉱山のid)を先頭から1件ずつ調べる

execute unless data storage test: mine_work.mine_queue[0] run return 0

data modify storage test: mine_work.check_arg set value {id:""}
data modify storage test: mine_work.check_arg.id set from storage test: mine_work.mine_queue[0]
data remove storage test: mine_work.mine_queue[0]
function test:mine/check with storage test: mine_work.check_arg

function test:mine/tick_loop
