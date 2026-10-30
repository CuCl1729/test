#> test:debug/menu/machine_loop
# @s = メニューを開いたプレイヤー。debug_work.machine_queue(asset.machine_ids のコピー)を1件ずつ、エッグと設置のボタンにして出す

execute unless data storage test: debug_work.machine_queue[0] run return 0

data modify storage test: debug_work.machine_arg set value {}
data modify storage test: debug_work.machine_arg.id set from storage test: debug_work.machine_queue[0]
function test:debug/menu/machine_line with storage test: debug_work.machine_arg

data remove storage test: debug_work.machine_queue[0]
function test:debug/menu/machine_loop
