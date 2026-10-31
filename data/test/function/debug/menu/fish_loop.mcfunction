#> test:debug/menu/fish_loop
# @s = メニューを開いたプレイヤー。debug_work.fish_pool_queue(asset.fish_pool_ids のコピー)を1件ずつ、目印をもらうボタンにして出す

execute unless data storage test: debug_work.fish_pool_queue[0] run return 0
data modify storage test: debug_work.fish_arg set value {id:""}
data modify storage test: debug_work.fish_arg.id set from storage test: debug_work.fish_pool_queue[0]
data remove storage test: debug_work.fish_pool_queue[0]
function test:debug/menu/fish_button with storage test: debug_work.fish_arg
function test:debug/menu/fish_loop
