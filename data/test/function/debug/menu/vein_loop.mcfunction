#> test:debug/menu/vein_loop
# @s = メニューを開いたプレイヤー。debug_work.vein_queue(asset.vein_ids のコピー)を1件ずつ、設置ボタンにして出す

execute unless data storage test: debug_work.vein_queue[0] run return 0

data modify storage test: debug_work.vein_arg set value {id:""}
data modify storage test: debug_work.vein_arg.id set from storage test: debug_work.vein_queue[0]
data remove storage test: debug_work.vein_queue[0]
function test:debug/menu/vein_button with storage test: debug_work.vein_arg

function test:debug/menu/vein_loop
