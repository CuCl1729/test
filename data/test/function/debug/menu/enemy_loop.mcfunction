#> test:debug/menu/enemy_loop
# @s = メニューを開いたプレイヤー。debug_work.enemy_queue(asset.enemy_ids のコピー)を1件ずつ、召喚ボタンにして出す

execute unless data storage test: debug_work.enemy_queue[0] run return 0

data modify storage test: debug_work.enemy_arg set value {}
data modify storage test: debug_work.enemy_arg.id set from storage test: debug_work.enemy_queue[0]
function test:debug/menu/enemy_button with storage test: debug_work.enemy_arg

data remove storage test: debug_work.enemy_queue[0]
function test:debug/menu/enemy_loop
