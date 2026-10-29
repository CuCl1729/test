#> test:mine/token/convert_loop
# mine_work.token_queue(目印の鉱山のid。重なっていてもよい)を先頭から1件ずつ変える。
# 同じ鉱山の2件目以降は、1件目で目印を全部消しているので何もしない

execute unless data storage test: mine_work.token_queue[0] run return 0

data modify storage test: mine_work.token_arg set value {id:""}
data modify storage test: mine_work.token_arg.id set from storage test: mine_work.token_queue[0]
data remove storage test: mine_work.token_queue[0]
function test:mine/token/convert_one with storage test: mine_work.token_arg

function test:mine/token/convert_loop
