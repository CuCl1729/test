#> test:debug/menu/station_loop
# @s = メニューを開いたプレイヤー。debug_work.station_queue(asset.station_ids のコピー)を1件ずつ、設置ボタンにして出す

execute unless data storage test: debug_work.station_queue[0] run return 0

data modify storage test: debug_work.station_arg set value {}
data modify storage test: debug_work.station_arg.id set from storage test: debug_work.station_queue[0]
function test:debug/menu/station_line with storage test: debug_work.station_arg

data remove storage test: debug_work.station_queue[0]
function test:debug/menu/station_loop
